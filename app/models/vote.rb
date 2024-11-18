# frozen_string_literal: true

class Vote < ApplicationRecord
  belongs_to :user, polymorphic: true, optional: true
  belongs_to :question
  belongs_to :answer

  validates :user_id, uniqueness: { scope: :question_id, message: 'You can only vote once per question' }
end
