module Api
  class ApiController < ActionController::API
    rescue_from Exception do |e|
      render_record_not_found_error if e.class == ActiveRecord::RecordNotFound
    end

    def render_record_not_found_error
      render json: {
        error: {
          status: "Record Not Found",
          code: 404,
          title: "Record Not Found",
          description: "This resource could not be found or does not exist."
        }
      },
      status: 404
    end
  end
end
