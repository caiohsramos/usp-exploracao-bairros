class SearchController < ApplicationController

    def index
        session[:search] = params[:search] if params[:search]
        session[:radius] = params[:radius] if params[:radius]
        search = session[:search]
        radius = session[:radius]
        if session[:search].empty? or session[:radius].empty?
            redirect_to :back, alert: 'Preencha todos os campos' and return
        end
        url = URI.encode("https://maps.googleapis.com/maps/api/place/textsearch/json?query=#{search}&radius=#{radius}&language=pt-BR&key=AIzaSyAntuka0SlCnh1H3mRdlb1hrWFznQtf4PM")
        data = JSON.load(open(url)) # é uma lista
        results = data['results']
        lat = results[0]['geometry']['location']['lat']
        lng = results[0]['geometry']['location']['lng']
        url = URI.encode("https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=#{lat},#{lng}&radius=#{radius}&type=all&language=pt-BR&key=AIzaSyAntuka0SlCnh1H3mRdlb1hrWFznQtf4PM")
        data = JSON.load(open(url))

        @results = data['results']
        @dict = {:accounting => 'contabilidade', :airport => 'aeroporto', :amusement_park => 'parque de diversões', :aquarium => 'aquário', :art_gallery => 'galeria de arte', :atm => 'caixa eletrônico', :bakery => 'padaria', :bank => 'banco', :bar => 'bar', :beauty_salon => 'salão de beleza', :bicycle_store => 'loja de bicicletas', :book_store => 'livraria', :bowling_alley => 'boliche', :bus_station => 'rodoviária', :cafe => 'lanchonete', :campground => 'local de acampamento', :car_dealer => 'revenda de automóveis', :car_rental => 'locação de automóveis', :car_repair => 'mecânico', :car_wash => 'lava-jato', :casino => 'cassino', :cemetery => 'cemitério', :church => 'igreja', :city_hall => 'prefeitura', :clothing_store => 'loja de roupas', :convenience_store => 'loja de conveniência', :courthouse => 'tribunal', :dentist => 'dentista', :department_store => 'loja de departamento', :doctor => 'médico', :electrician => 'eletricista', :electronics_store => 'loja de eletrônicos', :embassy => 'embaixada', :establishment => 'estabelecimento', :finance => 'finança', :fire_station => 'bombeiros', :florist => 'florista', :food => 'alimentação', :funeral_home => 'casa funerária', :furniture_store => 'loja de móveis', :gas_station => 'posto de gasolina', :general_contractor => 'empreiteiro geral', :grocery_or_supermarket => 'supermercado', :gym => 'academia', :hair_care => 'cabeleireiro', :hardware_store => 'loja de material de construção', :health => 'saúde', :hingu_temple => 'templo hindú', :home_goods_store => 'loja de artigos para o lar', :hospital => 'hospital', :insurance_agency => 'agência de seguros', :jewelry_store => 'joalheria', :laundry => 'lavanderia', :lawyer => 'advogacia', :library => 'biblioteca', :liquor_store => 'loja de bebidas alcoólicas', :local_goverment_office => 'escritório do governo local', :locksmith => 'chaveiro', :lodging => 'pousada', :meal_delivery => 'entrega de refeições', :meal_takeaway => 'refeição para viagem', :mosque => 'mesquita', :movie_rental => 'locadora de filmes', :movie_theater => 'cinema', :moving_company => 'empresa de mudanças', :museum => 'museu', :night_club => 'casa noturna', :painter => 'pintor', :park => 'parque', :parking => 'estacionamento', :pet_store => 'loja de animais', :pharmacy => 'farmácia', :physiotherapist => 'fisioterapeuta', :place_of_worship => 'local de culto', :plumber => 'encanador', :police => 'departamento de polícia', :post_office => 'correios', :real_estate_agency => 'agência imobiliária', :restaurant => 'restaurante', :roofing_contractor => 'contratante de telhados', :rv_park => 'parque de estacionamento', :school => 'escola', :shoe_store => 'loja de calçados', :shopping_mall => 'centro de compras', :spa => 'fonte de água mineral', :stadium => 'estádio', :storage => 'armazém', :store => 'loja', :subway_station => 'estação de metrô', :synagogue => 'sinagoga', :taxi_stand => 'ponto de táxi', :train_station => 'estação de trem', :transit_station => 'estação de trânsito', :travel_agency => 'agência de viagens', :university => 'universidade', :veterinary_care => 'veterinário', :zoo => 'zoológico'}
    end

    def show
        puts "place_id: #{params[:place_id]}"
        session[:place_id] = params[:place_id] if params[:place_id]
        @place_id = session[:place_id]
        url = URI.encode("https://maps.googleapis.com/maps/api/place/details/json?placeid=#{@place_id}&language=pt-BR&key=AIzaSyAntuka0SlCnh1H3mRdlb1hrWFznQtf4PM")
        data = JSON.load(open(url))
        result = data['result']
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
            puts "stars: #{@stars}"
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
