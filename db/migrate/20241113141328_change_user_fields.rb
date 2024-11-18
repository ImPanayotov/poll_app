# frozen_string_literal: true

class ChangeUserFields < ActiveRecord::Migration[7.1]
  def change
    change_table :users do |t|
      t.remove :name, type: :string
      t.inet :ip_address
    end
  end
end
