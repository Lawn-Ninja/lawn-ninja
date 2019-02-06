class ProvidersController < ApplicationController
  respond_to :html, :json

  def create
    @provider = Provider.new(
      provider_params
    )
    if @provider.save
      render json: {}
    else
      render json: {errors: @provider.errors.full_messages}, status: :unprocessable_entity
    end
  end

  def index
    @providers = Provider.all
    respond_with(@providers, :except => [:password_digest])
  end

  def show
    @provider = Provider.find_by_id(params[:id])
    respond_with(@provider, :except => [:password_digest])
  end

  def new
    @provider = Provider.new
    render "new.html.erb"
  end

  def update
    provider_id = params[:id]
    @provider = Provider.find_by_id(provider_id).tap { |provider| provider.update!(provider_params)
    }
    render json: {user: @provider}
  end

  def destroy
    provider = Provider.find_by_id(params[:id])
    provider.destroy
    redirect_to "landing_page_not_logged.html"
  end

  private

    def provider_params
      params.require(:provider).permit(:first_name, :last_name, :email, :password, :password_confirmation, :address, :city, :state, :zip_code, :phone_number)
    end
end
