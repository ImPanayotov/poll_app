# frozen_string_literal: true

class CreatePolls < ActiveRecord::Migration[7.1]
  def change
    create_table :polls do |t|
      t.string :title, null: false
      t.text :description

      t.timestamps
    end
  end
end
