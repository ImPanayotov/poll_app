class CreateVotes < ActiveRecord::Migration[7.1]
  def change
    create_table :votes do |t|
      t.integer :user_id
      t.references :answer, null: false, foreign_key: true

      t.timestamps
    end
  end
end
