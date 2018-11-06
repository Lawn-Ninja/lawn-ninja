class UsersController < ApplicationController
  respond_to :html, :json

  def create
    @user = User.new(
      name: params[:name],
      email: params[:email],
      password: params[:password],
      password_confirmation: params[:password_confirmation],
      address: params[:address],
      city: params[:city],
      state: params[:state],
      zip: params[:zip],
      phone_number: params[:phone_number],
      provider: params[:provider]
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
    render "new.html.erb"
  end

  def update
    user_id = current_user.id
    @user = User.find_by_id(user_id)
    @user.email = params[:email] || @user.email
    @user.address = params[:address] || @user.address
    @user.city = params[:city] || @user.city
    @user.state = params[:state] || @user.state
    @user.zip = params[:zip] || @user.zip
    @user.phone_number = params[:phone_number] || @user.phone_number
    @user.provider = params[:provider] || @user.provider
    @user.save
    respond_with(@user)
  end

  def destroy
    user = User.find_by_id(params[:id])
    user.destroy
    redirect_to "landing_page_not_logged.html"
  end


end 
