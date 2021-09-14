class ApplicationController < ActionController::API
  rescue_from ArgumentError, with: :invalid_params
  rescue_from ActiveRecord::RecordInvalid, with: :invalid_record
  # rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

  # def render_not_found_response(_exception)
  #   render json: { errors: 'Missing or invalid ID' }, status: :not_found
  # end

  private

  def invalid_params(e)
    render json: { errors: e }, status: :bad_request
  end

  def invalid_record(e)
    render json: { errors: e.record.errors.full_messages.to_sentence }, status: :bad_request
  end
end
