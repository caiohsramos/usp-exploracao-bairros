module GoogleApi

    def self.nearby_search(search, radius, page_token="")
        url = URI.encode("https://maps.googleapis.com/maps/api/place/textsearch/json?query=#{search}&radius=#{radius}&language=pt-BR&key=AIzaSyAntuka0SlCnh1H3mRdlb1hrWFznQtf4PM")
        data = JSON.load(open(url))
        results = data['results']
        lat = results[0]['geometry']['location']['lat']
        lng = results[0]['geometry']['location']['lng']
        url = URI.encode("https://maps.googleapis.com/maps/api/place/nearbysearch/json?pagetoken=#{page_token}&location=#{lat},#{lng}&radius=#{radius}&type=all&language=pt-BR&key=AIzaSyAntuka0SlCnh1H3mRdlb1hrWFznQtf4PM")
        JSON.load(open(url))
    end

    def self.place_details(place_id)
        url = URI.encode("https://maps.googleapis.com/maps/api/place/details/json?placeid=#{place_id}&language=pt-BR&key=AIzaSyAntuka0SlCnh1H3mRdlb1hrWFznQtf4PM")
        data = JSON.load(open(url))
        data['result']
    end

    def self.place_photos(photo_reference)
        URI.encode("https://maps.googleapis.com/maps/api/place/photo?maxheight=480&photoreference=#{photo_reference}&key=AIzaSyAntuka0SlCnh1H3mRdlb1hrWFznQtf4PM")
    end

    def self.static_map(formatted_address)
        URI.encode("https://maps.googleapis.com/maps/api/staticmap?center=#{formatted_address}&size=640x480&scale=1&markers=color:red|#{formatted_address}&key=AIzaSyAntuka0SlCnh1H3mRdlb1hrWFznQtf4PM")
    end
end
