class CreateGuest < ActiveRecord::Migration[6.1]
  def change
    create_table :guests, id: :uuid  do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :phone, null: false, array: true, default: []
      t.string :email, unique: true

      t.timestamps
    end
  end
end
