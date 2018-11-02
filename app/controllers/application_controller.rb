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

  def current_user
    if request.headers['Authorization'].present?
      token = request.headers['Authorization'].split(' ').last
      begin
        decoded_token = JWT.decode(
          token,
          Rails.application.credentials.fetch(ENV["SECRET_KEY_BASE"]),
          true,
          { algorithm: 'HS256' }
        )
        User.find_by(id: decoded_token[0]["user"])
      rescue JWT::ExpiredSignature
        nil
      end
    end
  end

  helper_method :current_user

  def authenticate_user
    unless current_user
      render json: {}, status: :unauthorized
    end
  end
end
