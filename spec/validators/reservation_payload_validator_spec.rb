require "rails_helper"

RSpec.describe ReservationPayloadValidator do
  it "validate a valid payload" do
    parser = Payloads::Airbnb.new(
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
    )

    validator = ReservationPayloadValidator.new(parser)

    expect(validator.valid?).to eq(true)
  end

  it "validate an invalid payload" do
    create(:reservation, code: '1111')

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
      },
      "currency" => "AUD",
      "payout_price" => "4200.00",
      "security_price" => "500",
      "total_price" => "4700.00"
    )

    validator = ReservationPayloadValidator.new(parser)

    expect(validator.valid?).to eq(false)
    expect(validator.errors).to eq({
      "email" => ["can't be blank"],
      "reservation_code" => ["has already been taken"]
    })
  end
end
