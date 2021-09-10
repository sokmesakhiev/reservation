class ReservationPayloadParser < BaseParser
  def parse
    adapter.new(attributes)
  end

  def adapter
    return Payloads::Airbnb if is_airbnb?
    return Payloads::BookingDotCom if is_booking_dot_com?

    Payloads::Error
  end

  def is_airbnb?
    attributes.key?("reservation_code")
  end

  def is_booking_dot_com?
    attributes.key?("reservation") && attributes["reservation"]["code"].present?
  end
end
