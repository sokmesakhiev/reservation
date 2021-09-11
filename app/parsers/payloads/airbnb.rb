module Payloads
  class Airbnb < BasePayload
    MAPPED_COLUMN = {
      code: "reservation_code",
      start_date: "start_date",
      end_date: "end_date",
      total_amount: "total_price",
      payout_amount: "payout_price",
      currency: "currency",
      security_price: "security_price",
      status: "status",
      number_of_nights: "nights",
      number_of_adults: "adults",
      number_of_children: "children",
      number_of_infants: "infants",
      number_of_guests: "guests",
      first_name: "first_name",
      last_name: "last_name",
      email: "email",
      phone: "phone"
    }

    def reservation_data
      data = {}
      data["code"] = attributes["reservation_code"]
      data["start_date"] = attributes["start_date"]
      data["end_date"] = attributes["end_date"]
      data["total_amount"] = attributes["total_price"]
      data["payout_amount"] = attributes["payout_price"]
      data["currency"] = attributes["currency"]
      data["security_price"] = attributes["security_price"]
      data["status"] = attributes["status"]
      data["number_of_nights"] = attributes["nights"]
      data["number_of_adults"] = attributes["adults"]
      data["number_of_children"] = attributes["children"]
      data["number_of_infants"] = attributes["infants"]
      data["number_of_guests"] = attributes["guests"]

      data.compact
    end

    def guest_data
      data = {}
      data["first_name"] = guest_attribute["first_name"]
      data["last_name"] = guest_attribute["last_name"]
      data["email"] = guest_attribute["email"]
      data["phone"] = [guest_attribute["phone"]]

      data.compact
    end

    def mapped_column
      MAPPED_COLUMN
    end

    private

    def guest_attribute
      attributes["guest"] || {}
    end
  end
end
