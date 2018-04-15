class CreateGuests < ActiveRecord::Migration[5.2]
  def change
    create_table :guests do |t|
      t.string :name, null: false
      t.citext :email, null: false, unique: true

      t.timestamps
    end
  end
end
