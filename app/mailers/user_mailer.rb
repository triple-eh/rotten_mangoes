class UserMailer < ApplicationMailer
  default from: "example_1@abcdefg.com"
  default url: "localhost:3000/movies"

  def welcome_email(user)
    @user = user
    mail(to: @user.email, subject: "Welcome to my awesome site!")
  end

  def account_deleted_email(user)
    @user = user
    mail(to: @user.email, subject: "Account successfully deleted")
  end
end
