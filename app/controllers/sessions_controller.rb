class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by email: params[:session][:email].downcase
    if user&.authenticate(params[:session][:password])
      actived_remember? user
    else
      flash.now[:danger] = t "session_controller.create_danger"
      render :new
    end
  end

  def destroy
    log_out
    redirect_to root_path
  end

  private

  def actived_remember? user
    if user.activated
      log_in user
      params[:session][:remember_me] == "1" ? remember(user) : forget(user)
      redirect_back_or user
    else
      flash[:warning] = t "session_controller_create.msg"
      redirect_to root_url
    end
  end
end
