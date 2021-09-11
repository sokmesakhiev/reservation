module Payloads
  class BookingDotCom < BasePayload
    MAPPED_COLUMN = {
      code: "code",
      start_date: "start_date",
      end_date: "end_date",
      total_amount: "total_paid_amount_accurate",
      payout_amount: "expected_payout_amount",
      currency: "host_currency",
      security_price: "listing_security_price_accurate",
      status: "status_type",
      number_of_nights: "nights",
      number_of_adults: "number_of_adults",
      number_of_children: "number_of_children",
      number_of_infants: "number_of_infants",
      number_of_guests: "number_of_guests",
      first_name: "guest_first_name",
      last_name: "guest_last_name",
      email: "guest_email",
      phone: "guest_phone_numbers"
    }

    def reservation_data
      data = {}
      data["code"] = reservation_attribute["code"]
      data["start_date"] = reservation_attribute["start_date"]
      data["end_date"] = reservation_attribute["end_date"]
      data["total_amount"] = reservation_attribute["total_paid_amount_accurate"]
      data["payout_amount"] = reservation_attribute["expected_payout_amount"]
      data["currency"] = reservation_attribute["host_currency"]
      data["security_price"] = reservation_attribute["listing_security_price_accurate"]
      data["status"] = reservation_attribute["status_type"]
      data["number_of_nights"] = reservation_attribute["nights"]
      data["number_of_adults"] = guest_details["number_of_adults"]
      data["number_of_children"] = guest_details["number_of_children"]
      data["number_of_infants"] = guest_details["number_of_infants"]
      data["number_of_guests"] = reservation_attribute["number_of_guests"]

      data.compact
    end

    def guest_data
      data = {}
      data["first_name"] = reservation_attribute["guest_first_name"]
      data["last_name"] = reservation_attribute["guest_last_name"]
      data["email"] = reservation_attribute["guest_email"]
      data["phone"] = reservation_attribute["guest_phone_numbers"]

      data.compact
    end

    def mapped_column
      MAPPED_COLUMN
    end

    private

    def reservation_attribute
      attributes["reservation"]
    end

    def guest_details
      reservation_attribute["guest_details"] || {}
    end
  end
end
