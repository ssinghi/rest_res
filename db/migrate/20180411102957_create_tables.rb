class CreateTables < ActiveRecord::Migration[5.2]
  def change
    create_table :tables do |t|
      t.belongs_to :restaurant, null: false, foreign_key: true
      t.citext :name, null: false
      t.integer :min_guests, limit: 2
      t.integer :max_guests, limit: 2
      t.timestamps
    end

    add_index :tables, [:restaurant_id, :name], unique: true
  end
end
