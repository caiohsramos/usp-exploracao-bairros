class SearchController < ApplicationController

    include GoogleApi

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
        @address_components = result['address_components']
        @formatted_address = result['formatted_address']
        @formatted_number = result['formatted_phone_number']
        opening_hours = result['opening_hours']
        if opening_hours
            @weekday_text = opening_hours['weekday_text']
        else
            @weekday_text = ['sem informação']
        end
        @map = GoogleApi.static_map(@formatted_address)
        @photos = []
        elements = result['photos']
        if elements
            elements.each do |element|
                @photos << GoogleApi.place_photos(element['photo_reference'])
            end
        end


        @reviews = Review.where("place_id = ?", session[:place_id])
        @review = Review.new
        @stars = 0.0
        count = 0

        @reviews.each do |review|
            @stars = @stars + review.rate
            count = count + 1
        end

        if (count == 0)
            count = 1
        end

        @stars = @stars / count
    end
end
