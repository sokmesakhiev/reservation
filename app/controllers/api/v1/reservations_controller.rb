module Api
  module V1
    class ReservationsController < BaseController
      def create
        parser = PayloadParser.new(params).parse

        if parser.valid?
          reservation = ReservationCreator.call(
            reservation_data: parser.reservation_data,
            guest_data: parser.guest_data
          )

          render_serialized_payload reservation
        else
          render_error_payload(parser.errors)
        end
      end

      private

      def resource_serializer
        ReservationSerializer
      end
    end
  end
end
