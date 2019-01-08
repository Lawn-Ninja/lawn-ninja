class ProviderSessionsController < ApplicationController

  def create
    provider = Provider.find_by(email: params[:email])
    if provider && provider.authenticate(params[:password])
      jwt = JWT.encode(
        {
          provider: provider.id, # the data to encode
          exp: 24.hours.from_now.to_i # the expiration time
        },
        Rails.application.credentials.fetch(:secret_key_base), # the secret key
        'HS256' # the encryption algorithm
      )
      render json: { jwt: jwt, email: provider.email, provider_id: provider.id, status: :created }
    else
      render json: {}
    end
  end

  def destroy
    session[:jwt] = nil
    render json: {}
  end
end
