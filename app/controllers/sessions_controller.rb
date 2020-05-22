class SessionsController < ApplicationController
  def  new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      flash[:notice] = "Hello #{user.username}, nice to see you again."
      redirect_to user

    else
      flash.now[:alert] = "Ops, there's something wrong"
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "Logged out successfully"
    redirect_to root_path
  end
end