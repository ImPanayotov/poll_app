# frozen_string_literal: true

class CreateGuestUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :guest_users do |t|
      t.inet :ip_address
      t.integer :votes_count, default: 0
      t.boolean :already_voted, default: false
      t.datetime :last_vote_at

      t.timestamps
    end
  end
end
