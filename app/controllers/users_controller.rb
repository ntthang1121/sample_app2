class UsersController < ApplicationController
  def show
    @user = User.find_by id: params[:id]
    return if @user

    flash[:warning] = I18n.t("user_nil.message_nil")
    redirect_to root_path
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = t "user_controller.create_success.message_success"
      redirect_to @user
    else
      render :new
    end
  end

  private

  def user_params
    params
      .require(:user).permit :name, :email, :password, :password_confirmation
  end
end