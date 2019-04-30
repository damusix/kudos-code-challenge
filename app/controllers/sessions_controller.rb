class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_email params[:email]

    if (!user)

      flash[:alert] = 'User not found'
      redirect_to '/login'
      return
    end

    cookies[:user] = user.id
    flash[:notice] = 'Logged in!'

    redirect_to '/'
  end

  def destroy
    cookies[:user] = 'nil'
    flash[:notice] = 'Logged out!'

    redirect_to '/'
  end
end
