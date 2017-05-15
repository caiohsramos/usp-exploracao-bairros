require 'open-uri'
class UserdataController < ApplicationController
  before_action :set_userdatum, only: [:show, :edit, :update, :destroy]

  # GET /userdata
  # GET /userdata.json
  def index
    session[:user_id] = params[:user_id] if params[:user_id] != nil

    @userdata = Userdatum.where(:user_id => session[:user_id])
  end

  # GET /userdata/1
  # GET /userdata/1.json
  def show
    url = URI.encode("https://maps.googleapis.com/maps/api/place/textsearch/json?query=#{@userdatum.name}&key=AIzaSyAntuka0SlCnh1H3mRdlb1hrWFznQtf4PM")
    @data = JSON.load(open(url))
    @name = @data['results'][0]['name']
    @formatted_address = @data['results'][0]['formatted_address']
  end

  # GET /userdata/new
  def new
    @userdatum = Userdatum.new
  end

  # GET /userdata/1/edit
  def edit
  end

  # POST /userdata
  # POST /userdata.json
  def create
    @userdatum = Userdatum.new(userdatum_params)
    @userdatum.user = User.find(session[:user_id])

    respond_to do |format|
      if @userdatum.save
        format.html { redirect_to @userdatum, notice: 'Dado adicionado com sucesso' }
        format.json { render :show, status: :created, location: @userdatum }
      else
        format.html { render :new }
        format.json { render json: @userdatum.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /userdata/1
  # PATCH/PUT /userdata/1.json
  def update
    respond_to do |format|
      if @userdatum.update(userdatum_params)
        format.html { redirect_to @userdatum, notice: 'Dado atualizado com sucesso' }
        format.json { render :show, status: :ok, location: @userdatum }
      else
        format.html { render :edit }
        format.json { render json: @userdatum.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /userdata/1
  # DELETE /userdata/1.json
  def destroy
    @userdatum.destroy
    respond_to do |format|
      format.html { redirect_to userdata_url, notice: 'Dado apagado com sucesso' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_userdatum
      @userdatum = Userdatum.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def userdatum_params
      params.require(:userdatum).permit(:name, :comment)
    end
end
