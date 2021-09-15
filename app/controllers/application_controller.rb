class ApplicationController < ActionController::API
  rescue_from ArgumentError, with: :invalid_params
  rescue_from ActiveRecord::RecordInvalid, with: :invalid_record

  private

  def invalid_params(error)
    render json: { errors: error }, status: :bad_request
  end

  def invalid_record(error)
    render json: { errors: error.record.errors.full_messages.to_sentence }, status: :bad_request
  end
end
