class CreateSessions < ActiveRecord::Migration[7.0]
  def change
    create_table :sessions do |t|
      t.bigint :user_id, null: false
      t.integer :duration_in_seconds, null: false

      t.timestamps
    end

    add_foreign_key :sessions, :users, column: :user_id, primary_key: :id
  end
end
