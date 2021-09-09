class CreateGuest < ActiveRecord::Migration[6.1]
  def change
    create_table :guests, id: :uuid do |t|
      t.string :first_name, null: false
      t.string :last_name
      t.string :phone, array: true, null: false
      t.string :email, unique: true

      t.timestamps
    end
  end
end
