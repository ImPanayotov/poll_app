# frozen_string_literal: true

class Answer < ApplicationRecord
  belongs_to :question
  has_many :votes, dependent: :destroy

  validates :content, presence: true, uniqueness: { scope: :question_id }
end
