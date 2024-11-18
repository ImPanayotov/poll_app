# frozen_string_literal: true

class Question < ApplicationRecord
  belongs_to :poll
  has_many :answers, dependent: :destroy
  has_many :votes, dependent: :destroy

  # accepts_nested_attributes_for :answers, allow_destroy: true

  validates :content, presence: true
end
