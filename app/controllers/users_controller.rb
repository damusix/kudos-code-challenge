class UsersController < ApplicationController

    def index

        render json: User.where.not(id: cookies[:user])
    end

    def create

        user = User.create create_params
        flash[:notice] = 'Account created!'
        params[:email] = user.email
        redirect_to '/'
    end

    def new
        @user = User.new
    end

    def total

        render json: current_user.kudos_totals
    end

private

    def create_params

        params
            .require(:user)
            .permit(:username, :email)
    end
end
