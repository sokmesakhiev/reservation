class ReservationPayloadValidator
  attr_reader :parser

  def initialize(parser)
    @parser = parser
  end

  def valid?
    guest.valid? && reservation.valid?
  end

  def errors
    return nil if valid?

    build_error
  end

  def build_error
    errors = {}

    guest.errors.messages.merge(reservation.errors.messages).each do |key, value|
      errors[parser.mapped_column.fetch(key, key)] = value
    end

    errors
  end

  def guest
    @guest ||= Guest.new(parser.guest_data)
  end

  def reservation
    @reservation ||= Reservation.new(guest: guest, **parser.reservation_data)
  end
end
