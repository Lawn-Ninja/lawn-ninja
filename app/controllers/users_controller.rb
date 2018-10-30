class UsersController < ApplicationController
  def create
    @user = User.new(
      name: params[:name],
      email: params[:email],
      password: params[:password],
      password_confirmation: params[:password_confirmation]
    )
    if @user.save
      redirect_to "/home"
    else
      render json: {errors: @user.errors.full_messages}, status: :unprocessable_entity
    end
  end

  def new
    render "new.html.erb"
  end
end 
