require "rails_helper"

RSpec.describe ReservationPayloadParser do
  it "parses payload from Airbnb payload" do
    payload = {
      "reservation_code" => "YYY12345678",
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
        "email" => "wayne_woodbridge@bnb.com"
      },
      "currency" => "AUD",
      "payout_price" => "4200.00",
      "security_price" => "500",
      "total_price" => "4700.00"
    }

    parser = ReservationPayloadParser.parse(payload)

    expect(parser.reservation_data).to eq({
      "code" => "YYY12345678",
      "start_date" => "2021-04-14",
      "end_date" => "2021-04-18",
      "total_amount" => "4700.00",
      "payout_amount" => "4200.00",
      "currency" => "AUD",
      "security_price" => "500",
      "status" => "Accepted",
      "number_of_nights" => 4,
      "number_of_adults" => 2,
      "number_of_children" => 2,
      "number_of_infants" => 0,
      "number_of_guests" => 4

    })
    expect(parser.guest_data).to eq({
      "first_name" => "Wayne",
      "last_name" => "Woodbridge",
      "phone" => ["639123456789"],
      "email" => "wayne_woodbridge@bnb.com"
    })
  end

  it "parses payload from Booking.com payload" do
    payload = {
      "reservation" => {
        "code" => "XXX12345678",
        "start_date" => "2021-03-12",
        "end_date" => "2021-03-16",
        "expected_payout_amount" => "3800.00",
        "guest_details" => {
          "localized_description" => "4 guests",
          "number_of_adults" => 2,
          "number_of_children" => 2,
          "number_of_infants" => 0
        },
        "guest_email" => "wayne_woodbridge@bnb.com",
        "guest_first_name" => "Wayne",
        "guest_last_name" => "Woodbridge",
        "guest_phone_numbers" => [
          "639123456789",
          "639123456789"
        ],
        "listing_security_price_accurate" => "500.00",
        "host_currency" => "AUD",
        "nights" => 4,
        "number_of_guests" => 4,
        "status_type" => "Accepted",
        "total_paid_amount_accurate" => "4300.00"
      }
    }

    parser = ReservationPayloadParser.parse(payload)

    expect(parser.reservation_data).to eq({
      "code" => "XXX12345678",
      "start_date" => "2021-03-12",
      "end_date" => "2021-03-16",
      "total_amount" => "4300.00",
      "payout_amount" => "3800.00",
      "currency" => "AUD",
      "security_price" => "500.00",
      "status" => "Accepted",
      "number_of_nights" => 4,
      "number_of_adults" => 2,
      "number_of_children" => 2,
      "number_of_infants" => 0,
      "number_of_guests" => 4

    })
    expect(parser.guest_data).to eq({
      "first_name" => "Wayne",
      "last_name" => "Woodbridge",
      "phone" => ["639123456789", "639123456789"],
      "email" => "wayne_woodbridge@bnb.com"
    })
  end

  it "parses invalid payload" do
    payload = { "foo" => "bar" }

    parser = ReservationPayloadParser.parse(payload)

    expect(parser.reservation_data).to eq({})
    expect(parser.guest_data).to eq({})
  end
end
