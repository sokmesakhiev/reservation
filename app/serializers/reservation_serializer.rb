class ReservationSerializer
  include FastJsonapi::ObjectSerializer
  set_type :reservation
  belongs_to :guest

  attributes :code, :start_date, :end_date, :total_amount, :payout_amount, :currency, :status, :number_of_nights,
             :number_of_adults, :number_of_children, :number_of_infants, :number_of_guests, :security_price
end
