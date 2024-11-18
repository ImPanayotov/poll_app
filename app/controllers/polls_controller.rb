# frozen_string_literal: true

# app/controllers/polls_controller.rb
class PollsController < ApplicationController
  before_action :set_poll, only: %i[show edit update destroy]

  def index
    @polls = Poll.all
  end

  def show
    @questions = @poll.questions.includes(:answers)
  end

  def new
    @poll = Poll.new
    authorize @poll
    @poll.questions.build.answers.build
  end

  def create
    @poll = Poll.new(poll_params)
    if @poll.save
      respond_to do |format|
        format.html { redirect_to @poll, notice: 'Poll was successfully created.' }
        format.turbo_stream
      end
    else
      render :new
    end
  end

  def edit; end

  def update
    authorize @poll

    if @poll.update(poll_params)
      redirect_to @poll, notice: 'Poll was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @poll = Poll.find(params[:id])
    authorize @poll

    @poll.destroy

    redirect_to polls_path
  end

  private

  def set_poll
    @poll = Poll.find(params[:id] || params[:poll_id])
  end

  def poll_params
    params.require(:poll).permit(
      :title,
      questions_attributes: [
        :id,
        :content,
        :_destroy,
        { answers_attributes: %i[
          id
          content
          _destroy
        ] }
      ]
    )
  end
end
