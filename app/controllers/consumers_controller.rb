class ConsumersController < ApplicationController
  respond_to :html, :json

  def create
    @consumer = Consumer.new(
      consumer_params
    )
    if @consumer.save
      render json: {}
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
