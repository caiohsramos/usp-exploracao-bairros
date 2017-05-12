class NeighborhoodsController < ApplicationController
  before_action :authenticate_user!

    def index
        @neighborhoods = Neighborhood.all
        
        unless current_user.admin?
            redirect_to :back, :alert => "Access denied."
        end
    end

    def show
        @neighborhood = Neighborhood.find Neighborhood.decrypt (params[:id])
        
        puts "nei: #{@neighborhood} - name: #{@neighborhood.name}"
    end
    
    def new
        @neighborhood = Neighborhood.new
    end
    
    def create
        @neighborhood = Neighborhood.new(neighborhood_params)

        if @neighborhood.save
            redirect_to @neighborhood, :flash => { :notice => "eighborhood created successfully." }
        else
            redirect_to new_neighborhood_path, alert: "Error creating eighborhood."
        end
    end
    
    def edit
        @neighborhood = Neighborhood.find Neighborhood.decrypt params[:id]
        
        @user = current_user

        unless @user.admin?
            redirect_to :back, :alert => "Access denied."
        end
    end
    
    def update
        @neighborhood = Neighborhood.find Neighborhood.decrypt params[:id]
        
        @user = current_user
        
        unless @user.admin?
            redirect_to :back, :alert => "Access denied."
        end
        
        if @neighborhood.update_attributes!(neighborhood_params)
                redirect_to @neighborhood, :flash => { :notice => "Neighborhood updated successfully." }
        
        else
            redirect_to edit_neighborhood_path, alert: "Error updating neighborhood: #{@neighborhood.errors.full_messages}"
        end
    end
    
    def destroy   
        @neighborhood = Neighborhood.find Neighborhood.decrypt params[:id]
        
        @user = current_user
        
        unless @user.admin?
            redirect_to :back, :alert => "Access denied."
        end

        
        if @neighborhood.destroy
                redirect_to neighborhoods_path, status: 303 , :flash => { :notice => "Neighborhood deleted successfully." }
        
        else
                redirect_to edit_neighborhood_path, alert: "Error deleting neighborhood: #{@neighborhood.errors.full_messages}"
        end
    end
    
    private
    
    def neighborhood_params
        params.require(:neighborhood).permit(:name)
    end

end

