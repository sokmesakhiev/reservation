class CreateReservation < ActiveRecord::Migration[6.1]
  def change
    create_table :reservations, id: :uuid do |t|
      t.uuid   :guest_id, index: true
      t.string :code, unique: true
      t.date   :start_date, null: false
      t.date   :end_date, null: false
      t.float  :total_amount, null: false
      t.float  :payout_amount, null: false
      t.string :currency, null: false
      t.string :status, null: false
      t.integer :number_of_nights, null:false
      t.integer :number_of_adults, null: false
      t.integer :number_of_children, null: false
      t.integer :number_of_infants, null: false
      t.integer :number_of_guests, null: false
      t.integer :security_price, null: false

      t.timestamps
    end
  end
end
