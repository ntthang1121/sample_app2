class UsersController < ApplicationController
  before_action :logged_in_user, except: %i(show new create)
  before_action :load_user, except: %i(new create index)
  before_action :correct_user, only: %i(edit update)
  before_action :admin_user, only: :destroy

  def index
    @users = User.page(params[:page]).per(Settings.per_page)
  end

  def show; end

  def new
    @user = User.new
  end

  def edit; end

  def update
    if @user.update(user_params)
      flash[:success] = t "user_controller.update.message_update_success"
      redirect_to @user
    else
      render :edit
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @user.send_activation_email
      flash[:info] = t "user_controller_create.msg_info"
      redirect_to root_url
    else
      render :new
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = t "user_controller.delete.message_delete_success"
    else
      flash[:danger] = t "user_controller.delete.message_delete_failed"
    end
    redirect_to users_url
  end

  private

  def user_params
    params
      .require(:user).permit :name, :email, :password, :password_confirmation
  end

  def logged_in_user
    return if logged_in?

    store_location
    flash[:danger] = t "logged_user.message_danger"
    redirect_to login_url
  end

  def load_user
    @user = User.find_by(id: params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
    return if @user

    flash[:warning] = t "user_nil.message_nil"
    redirect_to root_path
  end

  def correct_user
    load_user
    redirect_to(root_url) unless current_user?(@user)
  end

  def admin_user
    return if current_user.admin?

    flash[:danger] = t "admin_user.message"
    redirect_to root_url
  end
end
