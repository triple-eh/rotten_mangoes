class Admin::UsersController < ApplicationController
  
  before_action :restrict_non_admins

  def index
    @users = User.order(:lastname).page(params[:page])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to admin_users_path, notice: "New user created, #{@user.firstname}!"
    else
      render 'admin/users/new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def destroy
    @user = User.find(params[:id])
    UserMailer.account_deleted_email(@user).deliver_now
    @user.destroy
    flash[:alert] = "User, #{@user.email} deleted!"
    redirect_to admin_users_path
  end

  protected
  
  def user_params
    params.require(:user).permit(:email, :firstname, :lastname, :password, :password_confirmation, :is_admin)
  end
    
end
