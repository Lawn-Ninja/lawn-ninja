class ApplicationController < ActionController::Base
  before_action :set_headers
  protect_from_forgery with: :null_session

  def set_headers
  #   if session[:jwt]
  #     @jwt = session[:jwt]
  #     Unirest.default_header("Authorization", "Bearer #{session[:jwt]}")
  #   else
  #     Unirest.clear_default_headers()
  #   end
  end

  def current_consumer
    if request.headers['Authorization'].present?
      token = request.headers['Authorization'].split(' ').last
      begin
        decoded_token = JWT.decode(
          token,
          Rails.application.credentials.fetch(:secret_key_base),
          true,
          { algorithm: 'HS256' }
        )
        Consumer.find_by(id: decoded_token[0]["consumer"])
      rescue JWT::ExpiredSignature
        nil
      end
    end
  end

  helper_method :current_consumer

  def authenticate_consumer
    unless current_consumer
      render json: {}, status: :unauthorized
    end
  end
end
