class UsersController < ApplicationController

  def index
    @users = User.paginate(page: params[:page], per_page: 5)
  end

  def new
    @user =User.new()
  end

  def create
    @user = User.new(user_params)
    msg = "You have successfully signed up #{@user.username}".to_sym
    return redirect_to @user, notice: msg  if @user.save

    render :new
  end

  def edit
    @user =User.find(params[:id])
  end

  def update
    @user =User.find(params[:id])
    msg = "You have successfully updated your data".to_sym
    return redirect_to @user, notice: msg if @user.update(user_params)

    render :edit
  end

  def show
    @user = User.find(params[:id])
    @articles = @user.articles.paginate(page: params[:page], per_page: 5)
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end
end