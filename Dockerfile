# Define the Ruby version in sync with the .ruby-version and Gemfile
ARG RUBY_VERSION=3.3.5
FROM ruby:$RUBY_VERSION-slim as base

# Define application directory
WORKDIR /rails

# Set environment variables
ENV RAILS_ENV="development" \
    BUNDLE_DEPLOYMENT="1" \
    BUNDLE_PATH="/usr/local/bundle" \
    BUNDLE_WITHOUT="production" \
    BUNDLE_CLEAN="true" \
    SECRET_KEY_BASE="dummy_secret_key"

# Base build stage for installing dependencies and building assets
FROM base as build

# Synchronize system clock and install necessary build dependencies
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y \
    ntpdate && \
    ntpdate -u pool.ntp.org && \
    apt-get install --no-install-recommends -y \
    build-essential git libpq-dev libvips pkg-config nodejs && \
    rm -rf /var/lib/apt/lists/* /var/cache/apt/archives/*

RUN gem install rails

# Switch to non-root user for bundle install
RUN useradd -m rails
USER rails

# Copy Gemfile and Gemfile.lock
COPY Gemfile Gemfile.lock ./

# Install gems, including Rails
RUN bundle install && \
    rm -rf "${BUNDLE_PATH}"/ruby/*/cache "${BUNDLE_PATH}"/ruby/*/bundler/gems/*/.git

# Copy application code
COPY . .

# Ensure the rails user has write access to tmp directory, before switching to rails user
USER root
RUN mkdir -p /rails/tmp && \
    chmod -R 777 /rails/tmp

# Precompile bootsnap code and assets
RUN bundle exec bootsnap precompile --gemfile && \
    bundle exec bootsnap precompile app/ lib/ && \
    ./bin/rails assets:precompile

# Final production image
FROM base

# Synchronize system clock and install runtime dependencies only
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y \
    ntpdate && \
    ntpdate -u pool.ntp.org && \
    apt-get install --no-install-recommends -y \
    curl libvips postgresql-client nodejs && \
    rm -rf /var/lib/apt/lists/* /var/cache/apt/archives/*

# Install necessary gems (including Rails)
COPY --from=build /usr/local/bundle /usr/local/bundle

# Create the rails user in the final image
RUN useradd -m rails

# Copy application code
COPY --from=build /rails /rails

# Ensure the correct permissions for the application
RUN chown -R rails:rails /rails

# Switch to the non-root user to run the app
USER rails

# Set entrypoint for database preparation
ENTRYPOINT ["/rails/bin/docker-entrypoint"]

# Expose the Rails server port and start the server
EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]
