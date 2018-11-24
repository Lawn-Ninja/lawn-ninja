class UsersController < ApplicationController
  respond_to :html, :json

  def create
    @user = User.new(
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
      user_params
    )
    if @user.save
      redirect_to "/home"
    else
      render json: {errors: @user.errors.full_messages}, status: :unprocessable_entity
    end
  end

  def index
    @users = User.all
    respond_with(@users, :except => [:password_digest])
  end

  def show
    @user = User.find_by_id(params[:id])
    respond_with(@user, :except => [:password_digest])
  end

  def new
    @user = User.new
    render "new.html.erb"
  end

  def update
    user_id = params[:id]
    @user = User.find_by_id(user_id).tap { |user| user.update!(user_params)
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
    render json: {user: @user}
  end

  def destroy
    user = User.find_by_id(params[:id])
    user.destroy
    redirect_to "landing_page_not_logged.html"
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :address, :city, :state, :zip_code, :phone_number, :provider)
    end


end 
