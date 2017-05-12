class UsersController < ApplicationController
    before_action :authenticate_user!

    def index
        @users = User.all
    end

    def show
        @user = User.find User.decrypt params[:id]
              
        unless @user == current_user
            redirect_to :back, :alert => "Access denied."
        end
    end

end
