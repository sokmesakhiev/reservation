module Api
  module V1
    class BaseController < ActionController::API
      def render_serialized_payload(resource)
        render json: serialize_resource(resource), status: 200
      end

      def render_error_payload(error)
        render json: { error: error }, status: 422
      end

      def serialize_resource(resource)
        resource_serializer.new(
          resource,
          include: resource_includes,
        ).serializable_hash
      end

      def resource_includes
        if params[:include]&.blank?
          []
        elsif params[:include].present?
          params[:include].split(',')
        end
      end
    end
  end
end
