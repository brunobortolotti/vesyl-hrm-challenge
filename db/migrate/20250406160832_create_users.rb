class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :username, null: false
      t.string :gender, null: false
      t.integer :age, null: false
      t.integer :hr_zone1_bpm_min, null: false
      t.integer :hr_zone1_bpm_max, null: false
      t.integer :hr_zone2_bpm_min, null: false
      t.integer :hr_zone2_bpm_max, null: false
      t.integer :hr_zone3_bpm_min, null: false
      t.integer :hr_zone3_bpm_max, null: false

      t.timestamps
    end
  end
end
