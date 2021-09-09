module Payloads
  class BasePayload
    attr_reader :attributes

    def initialize(attributes)
      @attributes = attributes
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
        errors[mapped_column.fetch(key, key)] = value
      end

      errors
    end

    def guest
      @guest ||= Guest.new(guest_data)
    end

    def reservation
      @reservation ||= Reservation.new(guest: guest, **reservation_data)
    end
  end
end
