class NeighboodsController < ApplicationController
  before_action :authenticate_user!

    def index
        @neighboods= Neighbood.all
    end

    def show
        @neighbood = Neighbood.find(params[:id])
    end

end
