class SearchController < ApplicationController

    def index
        session[:search] = params[:search] if params[:search]
        session[:radius] = params[:radius] if params[:radius]
        search = session[:search]
        radius = session[:radius]
        if session[:search].empty? or session[:radius].empty?
            redirect_to :back, alert: 'Preencha todos os campos' and return
        end

        page_token = params[:page_token]
        data = GoogleApi.nearby_search(search, radius, page_token)
        @results = data['results']
        @next_page_token = data['next_page_token']
    end

    def show
        session[:place_id] = params[:place_id] if params[:place_id]
        @place_id = session[:place_id]
        result = GoogleApi.place_details(@place_id)

        @name = result['name']
        @formatted_number = result['formatted_phone_number']
        @formatted_address = result['formatted_address']
        @map = GoogleApi.static_map(@formatted_address)
        @weekday_text = get_weekday_text(result['opening_hours'])
        @photos = get_photos(result['photos'])

        @reviews = Review.where("place_id = ?", session[:place_id])
        @review = Review.new
        @count = @reviews.count
        @stars = get_stars(@reviews)
    end

    private

    def get_weekday_text(opening_hours)
        if opening_hours
            weekday_text = opening_hours['weekday_text']
        else
            weekday_text = ['sem informação']
        end
        return weekday_text
    end

    def get_photos(elements)
        photos = []
        if elements
            elements.each do |element|
                photos << GoogleApi.place_photos(element['photo_reference'])
            end
        end
        return photos
    end

    def get_stars(reviews)
        stars = 0.0
        reviews.each do |review|
            stars = stars + review.rate
        end
        return stars
    end
end
