require "rails_helper"

describe "/api/v1/reservations" do
  context "Airbnb" do
    describe "POST create" do
      it "creates reservation successfully" do
        post(
          api_v1_reservations_path(build_params)
        )

        expect(response.status).to eq(200)
      end

      it "handles invalid payload" do
        invalid_params = { "foo": "bar" }

        post(
          api_v1_reservations_path(invalid_params)
        )

        expect(response.status).to eq(422)
      end

      it "handles create with existing reservation" do
        create(:reservation, code: '1111')

        post(
          api_v1_reservations_path(build_params("reservation_code": "1111"))
        )

        expect(response.status).to eq(422)
        expect(json_response).to eq({
          "error"=>{
            "reservation_code"=>["has already been taken"]
          }
        })
      end

      def build_params(params = {})
        {
          "reservation_code": "YYY12345678",
          "start_date": "2021-04-14",
          "end_date": "2021-04-18",
          "nights": 4,
          "guests": 4,
          "adults": 2,
          "children": 2,
          "infants": 0,
          "status": "accepted",
          "guest": {
            "first_name": "Wayne",
            "last_name": "Woodbridge",
            "phone": "639123456789",
            "email": "wayne_woodbridge@bnb.com"
          },
          "currency": "AUD",
          "payout_price": "4200.00",
          "security_price": "500",
          "total_price": "4700.00"
        }.merge(params)
      end
    end
  end

  context "Booking.com" do
    describe "POST create" do
      it "returns a search result" do
        post(
          api_v1_reservations_path(build_params)
        )

        expect(response.status).to eq(200)
      end

      it "handles create with existing reservation" do
        create(:reservation, code: '1111')

        post(
          api_v1_reservations_path(build_params("reservation": { "code": "1111" }))
        )

        expect(response.status).to eq(422)
        expect(json_response).to eq({
          "error"=>{
            "code"=>["has already been taken"]
          }
        })
      end

      def build_params(params={})
        {
          "reservation": {
            "code": "XXX12345678",
            "start_date": "2021-03-12",
            "end_date": "2021-03-16",
            "expected_payout_amount": "3800.00",
            "guest_details": {
              "localized_description": "4 guests",
              "number_of_adults": 2,
              "number_of_children": 2,
              "number_of_infants": 0
            },
            "guest_email": "wayne_woodbridge@bnb.com",
            "guest_first_name": "Wayne",
            "guest_last_name": "Woodbridge",
            "guest_phone_numbers": [
              "639123456789",
              "639123456789"
            ],
            "listing_security_price_accurate": "500.00",
            "host_currency": "AUD",
            "nights": 4,
            "number_of_guests": 4,
            "status_type": "accepted",
            "total_paid_amount_accurate": "4300.00"
          }
        }.deep_merge(params)
      end
    end
  end
end
