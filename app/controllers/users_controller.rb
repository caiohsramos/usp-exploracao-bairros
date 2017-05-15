class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to :back, :alert => "Acesso proibido"
    end
    if @user == current_user
      redirect_to userdata_path(:user_id => @user.id)
    end
  end
end
