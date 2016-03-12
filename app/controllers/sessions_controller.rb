class SessionsController < ApplicationController


  def new
  end

  def create
    p "WM"*47
    p "hi"
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      @current_user ||= User.find_by(id: log_in(user))
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      log_in user
      redirect_to user
    else
      flash.now[:danger]="Invalid email/password combination"
      render 'static/home'
    end
  end

  def destroy
    p "WM"*47
    p "bye"
    log_out if logged_in?
    redirect_to root_url
  end
end
