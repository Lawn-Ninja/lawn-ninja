class SessionsController < ApplicationController

  def new
    render 'log_in.html.erb'
  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      jwt = JWT.encode(
        {
          user: user.id, # the data to encode
          exp: 24.hours.from_now.to_i # the expiration time
        },
        Rails.application.credentials.fetch(:secret_key_base), # the secret key
        'HS256' # the encryption algorithm
      )
      render json: {jwt: jwt, email: user.email}, status: :created
    else
      render json: {}
    end
  end

  def destroy
    session[:jwt] = nil
    flash[:success] = 'Successfully logged out!'
    redirect_to '/login'
  end
end
