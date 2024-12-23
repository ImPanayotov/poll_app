# frozen_string_literal: true

class CreateUser < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :role, null: false, default: 'user'
      t.string :email, null: false, default: ''
      t.string :encrypted_password, null: false, default: ''
      t.inet :ip_address

      ## Recoverable
      t.string :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      t.timestamps
    end

    add_index :users, :email, unique: true
    add_index :users, :reset_password_token, unique: true
  end
end
