class ReservationCreator < ApplicationService
  def call
    Reservation.transaction do
      guest = Guest.create_or_find_by(guest_data)

      Reservation.create!(guest: guest, **reservation_data)
    end
  end

  private

  def guest_data
    attributes.fetch(:guest_data)
  end

  def reservation_data
    attributes.fetch(:reservation_data)
  end
end
