class UsersController < ApplicationController
  before_action :fetch_categories
  before_action :set_user, only: [:show]
  before_action :require_user, except: [:show, :index, :new, :create]
  before_action :set_safe_user, only: [:edit, :update, :destroy]

  def index
    @users = User.paginate(page: params[:page], per_page: 5)
  end

  def new
    @user =User.new()
  end

  def create
    @user = User.new(user_params)
    if @user.save
      msg = "You have successfully signed up #{@user.username}".to_sym
      flash[:notice] = msg
      session[:user_id] = @user.id
      redirect_to @user
    else
    render :new
    end
  end

  def edit
  end

  def update
    msg = "You have successfully updated your data".to_sym
    return redirect_to @user, notice: msg if (current_user == @user || current_user.admin?) && @user.update(user_params)

    render :edit
  end

  def show
    @user = User.find(params[:id])
    @articles = @user.articles.paginate(page: params[:page], per_page: 5).order('created_at DESC')
  end

  def destroy
    session[:user_id] = nil if !current_user.admin?
    flash[:notice] = 'Account and all posts susccessfully deleted'
    return redirect_to root_path if @user.destroy
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

  def set_user
    @user =User.find(params[:id])
  end
  def set_safe_user
    return set_user if current_user.admin?
    @user = User.find(current_user.id)
  end
end