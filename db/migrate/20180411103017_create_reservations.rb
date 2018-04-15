class CreateReservations < ActiveRecord::Migration[5.2]
  def change
    create_table :reservations do |t|
      t.belongs_to :guest, null: false, index: true, foreign_key: true, index: true
      t.belongs_to :shift, null: false, index: true, foreign_key: true
      t.belongs_to :table, null: false, foreign_key: true
      t.datetime :time, null: false
      t.integer :guests_count, limit: 2, null: false, unsigned: true
      t.timestamps
    end

    add_index :reservations, [:shift_id, :time]
  end
end
