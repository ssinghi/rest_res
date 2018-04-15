class CreateShifts < ActiveRecord::Migration[5.2]
  def change
    create_table :shifts do |t|
      t.belongs_to :restaurant, null: false, foreign_key: true
      t.citext :name, null: false
      t.time :start_time, null: false
      t.time :end_time, null: false

      t.timestamps
    end

    add_index :shifts, [:restaurant_id, :name], unique: true
  end
end
