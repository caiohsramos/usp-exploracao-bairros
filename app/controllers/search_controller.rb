class SearchController < ApplicationController

    def index
        session[:search] = params[:search] if params[:search]
        session[:radius] = params[:radius] if params[:radius]
        search = session[:search]
        radius = session[:radius]
        if session[:search].empty? or session[:radius].empty?
            redirect_to :back, alert: 'Preencha todos os campos' and return
        end

        @results = GoogleApi.parse(search, radius)
        @dict = GoogleApi.dict
    end

    def show
        session[:place_id] = params[:place_id] if params[:place_id]
        @place_id = session[:place_id]
        url = URI.encode("https://maps.googleapis.com/maps/api/place/details/json?placeid=#{@place_id}&language=pt-BR&key=AIzaSyAntuka0SlCnh1H3mRdlb1hrWFznQtf4PM")
        data = JSON.load(open(url))
        result = data['result']
        puts "result: #{result}"
        @name = result['name']
        @address_components = result['address_components']
        @formatted_address = result['formatted_address']
        @formatted_number = result['formatted_phone_number']
        opening_hours = result['opening_hours']


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

        if opening_hours
            @weekday_text = opening_hours['weekday_text']
        else
            @weekday_text = ['sem informação']
        end

    end
end
