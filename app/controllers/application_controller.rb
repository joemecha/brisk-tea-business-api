class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

  def render_not_found_response(_exception)
    render json: { errors: 'Missing or invalid ID' }, status: :not_found
  end
end
