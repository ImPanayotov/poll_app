# frozen_string_literal: true

class AnswersController < ApplicationController
  before_action :set_question
  before_action :set_poll
  before_action :set_answer, only: [:destroy]

  def new
    @answer = @question.answers.new
  end

  def create
    @answer = @question.answers.new(answer_params)
    if @answer.save
      redirect_to @question.poll, notice: 'Answer was successfully created.'
    else
      render :new
    end
  end

  def destroy
    @answer.destroy
    redirect_to @question.poll, notice: 'Answer was successfully deleted.'
  end

  private

  def set_poll
    @poll = Poll.find(params[:poll_id])
  end

  def set_question
    @question = Question.find(params[:question_id])
  end

  def set_answer
    @answer = @question.answers.find(params[:id])
  end

  def answer_params
    params.require(:answer).permit(:content)
  end
end
