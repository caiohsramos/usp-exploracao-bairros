class ReviewsController < ApplicationController
    def new
        @review = Review.new
    end

    def create
        @review = Review.new review_params
        @review.user_id = current_user.id
        @review.place_id = session[:place_id]

        alreadyReviewd = nil
        alreadyReviewd = Review.where("user_id = ? AND place_id = ?", current_user.id, session[:place_id]).first

        if alreadyReviewd.nil? and @review.save!
            redirect_to search_show_path, notice: 'Comentario adiciondo com sucesso'
        else
            redirect_to search_show_path, alert: 'Erro! Você ja comentou sobre esse local'
        end
    end

    def edit
        @review = Review.find(params[:id])
    end

    def update
        @review = Review.find(params[:id])
        respond_to do |format|
            if @review.update(review_params)
                format.html {redirect_to search_show_path, notice: 'Comentário atualizado com sucesso'}
                format.json {render :show, status: :ok, location: @review}
            else
                format.html {render :edit}
                format.json {render json: @review.errors, status: :unprocessable_entity}
            end
        end
    end

    def destroy
        @review = Review.find(params[:id])
        @review.destroy
        respond_to do |format|
            format.html {redirect_to search_show_path, notice: 'Comentário apagado com sucesso'}
            format.json {head :no_content}
        end
    end

    private

    def review_params
        params.require(:review).permit(:rate, :user_id, :place_id, :comment)
    end
end
