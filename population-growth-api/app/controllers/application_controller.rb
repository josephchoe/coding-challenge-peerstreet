class ApplicationController < ActionController::API
  def render_error(status, error_message)
    error = {
      message: error_message
    }
    render json: { errors: [error] }, status: status
  end
end
