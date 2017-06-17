require 'open-uri'
class UserdataController < ApplicationController
    before_action :set_userdatum, only: [:show, :edit, :update, :destroy]

    # GET /userdata
    # GET /userdata.json
    def index
        @user = User.find(current_user.id)
        @userdata = Userdatum.where("user_id = ?", current_user.id)
        @reviews = Review.where("user_id = ?", current_user.id)
        @friends = Friend.where("user_id = ?", current_user.id).where("status = ?", 2)
    end

    # GET /userdata/1
    # GET /userdata/1.json
    def show
        redirect_to search_show_path(:place_id => @userdatum.place_id)
    end

    # GET /userdata/new
    def new
        @userdatum = Userdatum.new(:name => params[:name], :place_id => params[:place_id])
        session[:place_id] = params[:place_id]
    end

    # GET /userdata/1/edit
    def edit
    end

    # POST /userdata
    # POST /userdata.json
    def create
        @userdatum = Userdatum.new(userdatum_params)
        @userdatum.place_id = session[:place_id]
        @userdatum.user = current_user

        respond_to do |format|
            if @userdatum.save
                format.html {redirect_to search_index_path, notice: 'Comentário adicionado com sucesso'}
                format.json {render :show, status: :created, location: @userdatum}
            else
                format.html {render :new}
                format.json {render json: @userdatum.errors, status: :unprocessable_entity}
            end
        end
    end

    # PATCH/PUT /userdata/1
    # PATCH/PUT /userdata/1.json
    def update
        respond_to do |format|
            if @userdatum.update(userdatum_params)
                format.html {redirect_to userdata_path, notice: 'Comentário atualizado com sucesso'}
                format.json {render :show, status: :ok, location: @userdatum}
            else
                format.html {render :edit}
                format.json {render json: @userdatum.errors, status: :unprocessable_entity}
            end
        end
    end

    # DELETE /userdata/1
    # DELETE /userdata/1.json
    def destroy
        @userdatum.destroy
        respond_to do |format|
            format.html {redirect_to userdata_url, notice: 'Comentário apagado com sucesso'}
            format.json {head :no_content}
        end
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_userdatum
        @userdatum = Userdatum.find Userdatum.decrypt (params[:id])
        puts "@userdatum: #{@userdatum.place_id}"
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def userdatum_params
        params.require(:userdatum).permit(:name, :comment, :place_id)
    end
end
