class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:show, :want_to_gos, :wents]
  
  def show
    @user = User.find(params[:id])
    @restaurants = @user.restaurants.uniq
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to @user
    else
      render :new
    end
  end
  
  def want_to_gos
    @user = User.find(params[:id])
    @restaurants = @user.want_to_go_restaurants
  end
  
  def wents
    @user = User.find(params[:id])
    @restaurants = @user.went_restaurants
  end
  
  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end