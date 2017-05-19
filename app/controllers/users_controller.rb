class UsersController < ApplicationController
    before_action :authenticate_user!

    def index
        @users = User.all
    end

<<<<<<< HEAD
    def show
        @user = User.find User.decrypt params[:id]
              
        unless @user == current_user
            redirect_to :back, :alert => "Access denied."
        end
    end

=======
  def show
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to :back, :alert => "Acesso proibido"
    end
    if @user == current_user
      redirect_to userdata_path(:user_id => @user.id)
    end
  end
>>>>>>> ea760f78acb19afd1d9b0ddccaa4592d48db1e3b
end
