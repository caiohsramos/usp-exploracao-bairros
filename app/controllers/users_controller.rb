class UsersController < ApplicationController
    before_action :authenticate_user!

    def index
        @users = User.all
    end

    def show
        @user = User.find User.decrypt(params[:id])
        @userdata = Userdatum.where(:user_id => @user.id)
        @reviews = Review.where("user_id = ?", @user.id)
        @friends = Friend.where("user_id = ?", @user.id).where("status = ?", 2)
        @gravatar = "http://gravatar.com/avatar/#{Digest::MD5.hexdigest(@user.email)}?s=150"


        puts "Reviews: #{@reviews}"
        @reviews.each do |r|
            puts "r: #{r}"
        end
    end

    def add_friend
        @user = User.find current_user.id
        @friend = User.find User.decrypt params[:id]

        checkFriend = Friend.where("user_id = ?", @user.id).where("friend_id = ? ", @friend.id).first
        if @user.id == @friend.id
          redirect_to :back, :alert => "Este é você!"
          return
        end

        if !checkFriend
            @friendship = Friend.new(user_id: @user.id, friend_id: @friend.id, status: 1)

            if @friendship.save!
                redirect_to user_path(id: User.encrypt(@friend.id)), :flash => {:notice => "Solicitação feita com sucesso."}
            else
                redirect_to :back, :alert => "Problema ao solicitar amizade."
            end
        else
            redirect_to :back, :alert => "Você ja solicitou essa amizade."
        end
    end

    def notifications
        @user = current_user

        @friends = Friend.where("friend_id = ?", @user.id)
        puts "not: user=> #{@user.id}"
        @friendRequest = Array.new

        @friends.each do |friend|
            if friend.status == 1
                @friendRequest << friend
            end
            puts "friend: #{friend.user_id} | #{friend.friend_id}"
        end
    end

    def accept_friend
        @user = current_user
        @friend = User.find User.decrypt(params[:friend_id])

        @friendship1 = Friend.where("user_id = ?", @friend.id).where("friend_id = ?", @user.id)[0]
        @friendship1.status = 2;

        @friendship2 = Friend.new(user_id: @user.id, friend_id: @friend.id, status: 2)

        if @friendship1.save! and @friendship2.save!
            redirect_to user_notifications_path(user_id: User.encrypt(current_user.id)), :flash => {:notice => "Solicitação aceita com sucesso!"}
        else
            redirect_to :back, :alert => "Problema ao aceitar amizade amizade."
        end
    end

    def friends
        @user = User.find current_user.id
        @friends = Friend.where("user_id = ?", @user.id).where("status = ?", 2)
    end

    def cancel_friend
        @user = User.find current_user.id
        @friend = User.find User.decrypt(params[:friend_id])

        @friendship1 = Friend.where("user_id = ?", @user.id).where("friend_id = ?", @friend.id).first
        @friendship2 = Friend.where("user_id = ?", @friend.id).where("friend_id = ?", @user.id).first

        if @friendship1.delete and @friendship2.delete
            redirect_to :back, :flash => {:notice => "Remoção com sucesso!"}
        else
            redirect_to :back, :alert => "Problema ao cancelar amizade amizade."
        end
    end

    def cancel_request
        @user = User.find current_user.id
        @friend = User.find User.decrypt(params[:friend_id])
        @friendship2 = Friend.where("user_id = ?", @friend.id).where("friend_id = ?", @user.id).first

        if @friendship2.delete
            redirect_to :back, :flash => {:notice => "Remoção com sucesso!"}
        else
           redirect_to :back, :alert => "Problema ao cancelar amizade amizade."
        end
    end
end
