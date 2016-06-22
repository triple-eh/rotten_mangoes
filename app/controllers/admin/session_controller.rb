class Admin::SessionController < ApplicationController

  def create
    user = User.find(params[:user_id])
    session[:admin_user_id] = current_user.id
    session[:user_id] = user.id
    flash[:notice] = "Now viewing as #{user.full_name}"
    redirect_to admin_users_path
  end

  def destroy
    session[:user_id] = session[:admin_user_id]
    session[:admin_user_id] = nil
    redirect_to admin_users_path
  end

end
