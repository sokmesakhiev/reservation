class CreateReservation < ApplicationService
  def call
    data = parser.new(attributes)

    Reservation.transaction do
      guest = Guest.create_or_find_by(data.guest_params)

      Reservation.create!(guest: guest, **data.reservation_params)
    end
  end

  private

  def parser
    return Payloads::Airbnb if is_airbnb?
    return Payloads::BookingDotCom if is_booking_dot_com?
  end

  def is_airbnb?
    attributes.key?(:reservation_code)
  end

  def is_booking_dot_com?
    attributes.key?(:reservation) && attributes[:reservation][:code].present?
  end
end
