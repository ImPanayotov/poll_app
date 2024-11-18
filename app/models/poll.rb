# frozen_string_literal: true

class Poll < ApplicationRecord
  has_many :questions, dependent: :destroy
  accepts_nested_attributes_for :questions, allow_destroy: true

  validates :description, presence: true
  validates :title, presence: true, length: { minimum: 5 }
end
