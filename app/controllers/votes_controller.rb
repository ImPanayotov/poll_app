# frozen_string_literal: true

# app/controllers/votes_controller.rb
class VotesController < ApplicationController
  before_action :set_poll, :set_question, :set_answer

  def create
    @user = current_user || find_or_create_guest_user

    @vote = Vote.new(answer: @answer, question: @question, user: @user)
    authorize @vote

    if @vote.save
      respond_to do |format|
        format.html { redirect_to @poll, notice: 'Thank you for voting!' }
        format.turbo_stream
      end
    else
      respond_to do |format|
        format.html { redirect_to @poll, alert: @vote.errors.full_messages.to_sentence }
        format.turbo_stream
      end
    end
  end

  private

  def find_or_create_guest_user
    ip_address = request.remote_ip

    GuestUser.find_or_create_by(ip_address:) do |user|
      user.ip_address = ip_address
    end
  end

  def set_answer
    @answer = @question.answers.find(params[:answer_id])
  end

  def set_poll
    @poll = Poll.find(params[:poll_id])
  end

  def set_question
    @question = Question.find(params[:question_id])
  end
end
