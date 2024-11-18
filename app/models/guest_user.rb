# frozen_string_literal: true

class GuestUser < ApplicationRecord
  validates :ip_address, presence: true
end
