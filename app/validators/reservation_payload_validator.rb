class ReservationPayloadValidator
  attr_reader :parser

  def initialize(parser)
    @parser = parser
  end

  def valid?
    guest.valid? && reservation.valid?
  end

  def errors
    return {} if valid?

    build_error
  end

  def build_error
    errors = {}

    reservation.valid?
    guest.errors.messages.merge(reservation.errors.messages).each do |key, value|
      errors[parser.mapped_column.fetch(key, key)] = value.to_a
    end

    errors
  end

  def guest
    @guest ||= Guest.find_by(parser.guest_data) || Guest.new(parser.guest_data)
  end

  def reservation
    @reservation ||= Reservation.new(guest: guest, **parser.reservation_data)
  end
end
