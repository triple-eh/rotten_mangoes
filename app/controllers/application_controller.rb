class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

  def restrict_access
    if !current_user
      flash[:alert] = "You must log in"
      redirect_to new_session_path
    end
  end

  def restrict_non_admins
    unless current_user.is_admin? || admin_user
      flash[:alert] = "Access restricted"
      redirect_to root_path
    end
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def admin_user
    @admin_user = User.find(session[:admin_id]) if session[:admin_id]
  end

  helper_method :current_user, :admin_user
  
end
