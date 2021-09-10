module Api
  module V1
    class ReservationsController < BaseController
      def create
        parser = ReservationPayloadParser.new(params).parse
        validator = ReservationPayloadValidator.new(parser)

        if validator.valid?
          reservation = ReservationCreator.call(
            reservation_data: parser.reservation_data,
            guest_data: parser.guest_data
          )

          render_serialized_payload reservation
        else
          render_error_payload(validator.errors)
        end
      end

      def update
        parser = ReservationPayloadParser.new(params).parse
        reservation = Reservation.find_by!(code: parser.reservation_data["code"])
        updatable = reservation.update(parser.reservation_data)

        if updatable
          render_serialized_payload reservation
        else
          render_error_payload(reservation.errors.messages)
        end
      end

      private

      def resource_serializer
        ReservationSerializer
      end
    end
  end
end
