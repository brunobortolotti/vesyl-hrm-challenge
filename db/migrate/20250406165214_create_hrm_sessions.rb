class CreateHrmSessions < ActiveRecord::Migration[7.0]
  def change
    create_table :hrm_sessions do |t|
      t.bigint :user_id, null: false
      t.integer :duration_in_seconds, null: false
      t.datetime :created_at, null: false
    end

    add_foreign_key :hrm_sessions, :users, column: :user_id, primary_key: :id
  end
end
