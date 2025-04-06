class CreateHrmDataPoints < ActiveRecord::Migration[7.0]
  def change
    create_table :hrm_data_points, id: false do |t|
      t.bigint :hrm_session_id, null: false
      t.integer :beats_per_minute, null: false
      t.datetime :reading_started_at, null: false
      t.datetime :reading_ended_at, null: false
      t.integer :duration_in_seconds, null: false
    end

    add_foreign_key :hrm_data_points, :hrm_sessions, column: :hrm_session_id, primary_key: :id
  end
end
