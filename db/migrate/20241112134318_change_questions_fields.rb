# frozen_string_literal: true

class ChangeQuestionsFields < ActiveRecord::Migration[7.1]
  def change
    change_table :questions do |t|
      t.rename :title, :content
      t.references :poll, foreign_key: true
    end
  end
end
