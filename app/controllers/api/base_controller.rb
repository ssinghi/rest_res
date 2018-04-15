class Api::BaseController < ActionController::Base
  rescue_from ActiveRecord::RecordNotFound, with: :not_found!

  private

  def not_found!
    error!(:not_found, error_hash('not_found'))
  end

  def unprocessable!(message = nil)
    error!(:unprocessable_entity, error_hash('unprocessable', message))
  end

  def error!(http_status_code, error_hash)
    render json: error_hash.to_json, status: http_status_code
  end

  def error_hash(code, message = nil)
    error_hash = {}
    error_hash[:error_code] = code
    error_hash[:error_message] = message if message.present?
    error_hash
  end
end
