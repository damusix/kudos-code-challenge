class ApplicationController < ActionController::Base
  layout "application"
  helper_method :current_user

  def current_user

    if cookies[:user] && cookies[:user] != 'nil'
      @current_user ||= User.find cookies[:user]
    else
      @current_user = nil
    end

    @current_user
  end
end
