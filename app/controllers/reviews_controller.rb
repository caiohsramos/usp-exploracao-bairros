class ReviewsController < ApplicationController
    def new
        @review = Review.new
    end
    
    def create
        @review = Review.new review_params
        @review.user_id = current_user.id
        @review.place_id = session[:place_id]
        
        alreadyReviewd = nil
        alreadyReviewd = Review.where("user_id = ?", current_user.id).first
        puts "alreadyReviewd"
        puts alreadyReviewd.nil?
        puts current_user.id
        puts alreadyReviewd
        if alreadyReviewd.nil? and @review.save!
            redirect_to search_show_path, :flash => {notice => "Comentario adiciondo com sucesso."}
            
        else
            redirect_to search_show_path, alert: "Erro! Você ja comentou sobre esse local."
        end
        
    end
    
    
    
    private
    
    def review_params
        params.require(:review).permit(:rate, :user_id, :place_id, :comment)
    end
end
