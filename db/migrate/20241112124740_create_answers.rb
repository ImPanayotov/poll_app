# frozen_string_literal: true

class CreateAnswers < ActiveRecord::Migration[7.1]
  def change
    create_table :answers do |t|
      t.string :content
      t.references :question, null: false, foreign_key: true

      t.timestamps
    end

    add_index :answers, %i[content question_id], unique: true
  end
end
