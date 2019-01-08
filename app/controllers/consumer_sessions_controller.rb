class ConsumerSessionsController < ApplicationController

  def create
    consumer = Consumer.find_by(email: params[:email])
    if consumer && consumer.authenticate(params[:password])
      jwt = JWT.encode(
        {
          consumer: consumer.id, # the data to encode
          exp: 24.hours.from_now.to_i # the expiration time
        },
        Rails.application.credentials.fetch(:secret_key_base), # the secret key
        'HS256' # the encryption algorithm
      )
      render json: {jwt: jwt, email: consumer.email, consumer_id: consumer.id}, status: :created
    else
      render json: {}
    end
  end

  def destroy
    session[:jwt] = nil
    # flash[:success] = 'Successfully logged out!'
    # redirect_to '/login'
    render json: {}
  end
end
