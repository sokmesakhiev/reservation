require "rails_helper"

RSpec.describe ReservationCreator do
  it "creates reservation and guest" do
    parser = Payloads::Airbnb.new(
      "reservation_code" => "1111",
      "start_date" => "2021-04-14",
      "end_date" => "2021-04-18",
      "nights" => 4,
      "guests" => 4,
      "adults" => 2,
      "children" => 2,
      "infants" => 0,
      "status" => "Accepted",
      "guest" => {
        "first_name" => "Wayne",
        "last_name" => "Woodbridge",
        "phone" => "639123456789",
        "email" => "guest@airbnb.com"
      },
      "currency" => "AUD",
      "payout_price" => "4200.00",
      "security_price" => "500",
      "total_price" => "4700.00"
    )

    reservation = ReservationCreator.call(
      reservation_data: parser.reservation_data,
      guest_data: parser.guest_data
    )

    expect(reservation).to have_attributes(
      "code" => "1111",
      "currency" => "AUD",
      "number_of_adults" => 2,
      "number_of_children" => 2,
      "number_of_guests" => 4,
      "number_of_infants" => 0,
      "number_of_nights" => 4,
      "payout_amount" => 4200.0,
      "security_price" => 500,
      "status" => "Accepted",
      "total_amount" => 4700.0,
      "start_date" => Date.parse("2021-04-14"),
      "end_date" => Date.parse("2021-04-18")
    )
    expect(reservation.guest).to have_attributes(
      first_name: "Wayne",
      last_name: "Woodbridge",
      email: "guest@airbnb.com",
      phone: ["639123456789"]
    )
  end
end
