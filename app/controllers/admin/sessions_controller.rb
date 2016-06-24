class Admin::SessionsController < ApplicationController

  def become
    user = User.find(params[:user_id])
    session[:user_id] = user.id
    flash[:notice] = "Now viewing as #{user.full_name}"
    redirect_to admin_users_path
  end

  def destroy
    session[:user_id] = session[:admin_id]
    redirect_to admin_users_path
  end

end
