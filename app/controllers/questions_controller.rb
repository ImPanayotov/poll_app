# frozen_string_literal: true

class QuestionsController < ApplicationController
  before_action :set_poll
  before_action :set_question, only: %i[edit update destroy]

  def edit; end

  def update
    if @question.votes.any? && question_params[:content].present?
      redirect_to @poll, alert: 'You cannot change the question after someone has voted.'
      return
    end

    if @question.update(question_params)
      redirect_to @poll, notice: 'Question was successfully updated.'
    else
      render :edit
    end
  end

  def new
    @question = @poll.questions.new
  end

  def create
    @poll = Poll.find(params[:poll_id])
    @question = @poll.questions.new(question_params)

    if @question.save
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to @poll, notice: 'Question added successfully.' }
      end
    else
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to @poll, alert: 'Failed to add question.' }
      end
    end
  end

  def destroy
    @question.destroy
    redirect_to @poll, notice: 'Question was successfully deleted.'
  end

  private

  def set_poll
    @poll = Poll.find(params[:poll_id])
  end

  def set_question
    @question = @poll.questions.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:content, answers_attributes: %i[id content _destroy])
  end
end
