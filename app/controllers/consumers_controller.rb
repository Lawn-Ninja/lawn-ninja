class ConsumersController < ApplicationController
  respond_to :html, :json

  def create
    @consumer = Consumer.new(
      # name: params[:name],
      # email: params[:email],
      # password: params[:password],
      # password_confirmation: params[:password_confirmation],
      # address: params[:address],
      # city: params[:city],
      # state: params[:state],
      # zip_code: params[:zip_code],
      # phone_number: params[:phone_number],
      # provider: params[:provider]
      consumer_params
    )
    if @consumer.save
      redirect_to "/home"
    else
      render json: {errors: @consumer.errors.full_messages}, status: :unprocessable_entity
    end
  end

  def index
    @consumers = Consumer.all
    respond_with(@consumers, :except => [:password_digest])
  end

  def show
    @consumer = Consumer.find_by_id(params[:id])
    respond_with(@consumer, :except => [:password_digest])
  end

  def new
    @consumer = Consumer.new
    render "new.html.erb"
  end

  def update
    consumer_id = params[:id]
    @consumer = Consumer.find_by_id(consumer_id).tap { |consumer| consumer.update!(consumer_params)
    }
    # @user.email = params[:email] || @user.email
    # @user.address = params[:address] || @user.address
    # @user.city = params[:city] || @user.city
    # @user.state = params[:state] || @user.state
    # @user.zip_code = params[:zip_code] || @user.zip_code
    # @user.phone_number = params[:phone_number] || @user.phone_number
    # @user.provider = params[:provider] || @user.provider
    # @user.save
    # respond_with(@user)
    # p @user
    render json: {user: @consumer}
  end

  def destroy
    consumer = Consumer.find_by_id(params[:id])
    consumer.destroy
    redirect_to "landing_page_not_logged.html"
  end

  private

    def consumer_params
      params.require(:consumer).permit(:first_name, :last_name, :email, :password, :password_confirmation, :address, :city, :state, :zip_code, :phone_number)
    end


end 
