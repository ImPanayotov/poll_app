# frozen_string_literal: true

class ChangeVotesFields < ActiveRecord::Migration[7.1]
  def change
    change_table :votes do |t|
      t.remove :user_id, type: :integer
      t.references :user, polymorphic: true, null: true
      t.references :question, foreign_key: true
    end

    add_index :votes, %i[user_id question_id], unique: true
  end
end
