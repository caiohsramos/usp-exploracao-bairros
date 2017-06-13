class SearchController < ApplicationController
    require 'set'

    def index
        session[:search] = params[:search] if params[:search]
        session[:radius] = params[:radius] if params[:radius]
        @search = session[:search]
        @radius = session[:radius]
        type = params[:type]
        if session[:search].empty? or session[:radius].empty?
            redirect_to :back, alert: 'Preencha todos os campos' and return
        end

        page_token = params[:page_token]
        results = GoogleApi.text_search(@search)
        data = GoogleApi.nearby_search(results, @radius, page_token, type)
        @results = data['results']
        @types = get_types(@results)
        @next_page_token = data['next_page_token']
        @origin_id = results['place_id']
    end

    def show
        session[:place_id] = params[:place_id] if params[:place_id]
        @place_id = session[:place_id]
        @origin_id = params[:origin_id]
        result = GoogleApi.place_details(@place_id)
        @name = result['name']
        @formatted_number = result['formatted_phone_number']
        @formatted_address = result['formatted_address']
        @map = GoogleApi.get_map(@origin_id, @place_id)
        @weekday_text = get_weekday_text(result['opening_hours'])
        @photos = get_photos(result['photos'])

        @reviews = Review.where("place_id = ?", session[:place_id])
        @review = Review.new
        @count = @reviews.count
        @stars = get_stars(@reviews)
    end

    private

    def get_types(results)
        types = SortedSet.new
        results.each do |result|
            result['types'].each do |type|
                types.add(type)
            end
        end
        return types
    end

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
