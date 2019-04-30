class PagesController < ApplicationController

    before_action :current_user

    def home

        if !@current_user

            redirect_to '/login'
            return
        end
    end
end