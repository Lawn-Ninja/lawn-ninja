class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session

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
        Consumer.find_by(id: decoded_token[0]['consumer'])
      rescue JWT::ExpiredSignature
        nil
      end
    end
  end

  def current_provider
    if request.headers['Authorization'].present?
      token = request.headers['Authorization'].split(' ').last
      begin
        decoded_token = JWT.decode(
          token,
          Rails.application.credentials.fetch(:secret_key_base),
          true,
          { algorithm: 'HS256' }
        )
        Provider.find_by(id: decoded_token[0]['provider'])
      rescue JWT::ExpiredSignature
        nil
      end
    end
  end

  helper_method :current_consumer
  helper_method :current_provider

  def authenticate_consumer
    unless current_consumer
      render json: {}, status: :unauthorized
    end
  end

  def authenticate_provider
    unless current_provider
      render json: {}, status: :unauthorized
    end
  end
end
