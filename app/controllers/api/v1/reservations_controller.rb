module Api
  module V1
    class ReservationsController < ActionController::API
      def create
        reservation = CreateReservation.call(params)
        if reservation.success

        else

        end
      end
    end
  end
end
