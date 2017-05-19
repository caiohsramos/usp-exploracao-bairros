class ReviewsController < ApplicationController
    def new
        @review = Review.new
    end
    
    def create
        @review = Review.new review_params
        @review.user_id = current_user.id
        @review.place_id = session[:place_id]
        
        if @review.save!
            redirect_to search_show_path
        end
        
    end
    
    
    
    private
    
    def review_params
        params.require(:review).permit(:rate, :user_id, :place_id, :comment)
    end
end
