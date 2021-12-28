class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by email: params[:session][:email].downcase
    if user&.authenticate params[:session][:password]
      if user.activated
        login user
      else
        flash[:warning] = t "errors.not_activated"
        redirect_to root_url
      end
    else
      flash.now[:danger] = t "errors.invalid_email_password_combination"
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to static_pages_home_path
  end
end
