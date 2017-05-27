module GoogleApi
    @dict = {:accounting => 'contabilidade', :airport => 'aeroporto', :amusement_park => 'parque de diversões', :aquarium => 'aquário', :art_gallery => 'galeria de arte', :atm => 'caixa eletrônico', :bakery => 'padaria', :bank => 'banco', :bar => 'bar', :beauty_salon => 'salão de beleza', :bicycle_store => 'loja de bicicletas', :book_store => 'livraria', :bowling_alley => 'boliche', :bus_station => 'rodoviária', :cafe => 'lanchonete', :campground => 'local de acampamento', :car_dealer => 'revenda de automóveis', :car_rental => 'locação de automóveis', :car_repair => 'mecânico', :car_wash => 'lava-jato', :casino => 'cassino', :cemetery => 'cemitério', :church => 'igreja', :city_hall => 'prefeitura', :clothing_store => 'loja de roupas', :convenience_store => 'loja de conveniência', :courthouse => 'tribunal', :dentist => 'dentista', :department_store => 'loja de departamento', :doctor => 'médico', :electrician => 'eletricista', :electronics_store => 'loja de eletrônicos', :embassy => 'embaixada', :establishment => 'estabelecimento', :finance => 'finança', :fire_station => 'bombeiros', :florist => 'florista', :food => 'alimentação', :funeral_home => 'casa funerária', :furniture_store => 'loja de móveis', :gas_station => 'posto de gasolina', :general_contractor => 'empreiteiro geral', :grocery_or_supermarket => 'supermercado', :gym => 'academia', :hair_care => 'cabeleireiro', :hardware_store => 'loja de material de construção', :health => 'saúde', :hingu_temple => 'templo hindú', :home_goods_store => 'loja de artigos para o lar', :hospital => 'hospital', :insurance_agency => 'agência de seguros', :jewelry_store => 'joalheria', :laundry => 'lavanderia', :lawyer => 'advogacia', :library => 'biblioteca', :liquor_store => 'loja de bebidas alcoólicas', :local_goverment_office => 'escritório do governo local', :locksmith => 'chaveiro', :lodging => 'pousada', :meal_delivery => 'entrega de refeições', :meal_takeaway => 'refeição para viagem', :mosque => 'mesquita', :movie_rental => 'locadora de filmes', :movie_theater => 'cinema', :moving_company => 'empresa de mudanças', :museum => 'museu', :night_club => 'casa noturna', :painter => 'pintor', :park => 'parque', :parking => 'estacionamento', :pet_store => 'loja de animais', :pharmacy => 'farmácia', :physiotherapist => 'fisioterapeuta', :place_of_worship => 'local de culto', :plumber => 'encanador', :police => 'departamento de polícia', :post_office => 'correios', :real_estate_agency => 'agência imobiliária', :restaurant => 'restaurante', :roofing_contractor => 'contratante de telhados', :rv_park => 'parque de estacionamento', :school => 'escola', :shoe_store => 'loja de calçados', :shopping_mall => 'centro de compras', :spa => 'fonte de água mineral', :stadium => 'estádio', :storage => 'armazém', :store => 'loja', :subway_station => 'estação de metrô', :synagogue => 'sinagoga', :taxi_stand => 'ponto de táxi', :train_station => 'estação de trem', :transit_station => 'estação de trânsito', :travel_agency => 'agência de viagens', :university => 'universidade', :veterinary_care => 'veterinário', :zoo => 'zoológico'}

    def self.nearby_search(search, radius)
        url = URI.encode("https://maps.googleapis.com/maps/api/place/textsearch/json?query=#{search}&radius=#{radius}&language=pt-BR&key=AIzaSyAntuka0SlCnh1H3mRdlb1hrWFznQtf4PM")
        data = JSON.load(open(url))
        results = data['results']
        lat = results[0]['geometry']['location']['lat']
        lng = results[0]['geometry']['location']['lng']
        url = URI.encode("https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=#{lat},#{lng}&radius=#{radius}&type=all&language=pt-BR&key=AIzaSyAntuka0SlCnh1H3mRdlb1hrWFznQtf4PM")
        data = JSON.load(open(url))
        data['results']
    end

    def self.place_details(place_id)
        url = URI.encode("https://maps.googleapis.com/maps/api/place/details/json?placeid=#{place_id}&language=pt-BR&key=AIzaSyAntuka0SlCnh1H3mRdlb1hrWFznQtf4PM")
        data = JSON.load(open(url))
        data['result']
    end

    def self.place_photos(photo_reference)
        URI.encode("https://maps.googleapis.com/maps/api/place/photo?maxheight=360&photoreference=#{photo_reference}&key=AIzaSyAntuka0SlCnh1H3mRdlb1hrWFznQtf4PM")
    end

    def self.static_map(formatted_address)
        URI.encode("https://maps.googleapis.com/maps/api/staticmap?center=#{formatted_address}&size=640x360&scale=2&markers=color:red|#{formatted_address}&key=AIzaSyAntuka0SlCnh1H3mRdlb1hrWFznQtf4PM")
    end

    def self.dict
        @dict
    end
end
