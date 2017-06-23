module GoogleApi

    # Google Place Search API
    def self.text_search(search)
        url = URI.encode("https://maps.googleapis.com/maps/api/place/textsearch/json?query=#{search}&language=pt-BR&key=" + ENV['googleapikey'])
        data = JSON.load(open(url))
        data['results'][0]
    end

    def self.nearby_search(results, radius, page_token="", type="all")
        lat = results['geometry']['location']['lat']
        lng = results['geometry']['location']['lng']
        url = URI.encode("https://maps.googleapis.com/maps/api/place/nearbysearch/json?pagetoken=#{page_token}&location=#{lat},#{lng}&radius=#{radius}&type=#{type}&language=pt-BR&key=" + ENV['googleapikey'])
        JSON.load(open(url))
    end


    # Google Place Details API
    def self.place_details(place_id)
        url = URI.encode("https://maps.googleapis.com/maps/api/place/details/json?placeid=#{place_id}&language=pt-BR&key=" + ENV['googleapikey'])
        data = JSON.load(open(url))
        data['result']
    end

    def self.get_coordinates(place_id)
        coordinates = {}
        coordinates['lat'] = place_details(place_id)['geometry']['location']['lat']
        coordinates['lng'] = place_details(place_id)['geometry']['location']['lng']
        return coordinates
    end


    # Google Place Photos API
    def self.place_photos(photo_reference)
        URI.encode("https://maps.googleapis.com/maps/api/place/photo?maxheight=480&photoreference=#{photo_reference}&key=" + ENV['googleapikey'])
    end


    # Google Static Map API
    def self.static_map(coordinates, polyline_data = "")
        URI.encode("https://maps.googleapis.com/maps/api/staticmap?center=#{coordinates['lat']},#{coordinates['lng']}&size=640x480&path=enc:#{polyline_data}&scale=1&markers=color:red|#{coordinates['lat']},#{coordinates['lng']}&key=" + ENV['googleapikey'])
    end

    def self.get_map(origin_id, destination_id)
        if not origin_id
            polyline = directions(destination_id, destination_id)
        else
            polyline = directions(origin_id, destination_id)
        end
        coordinates = get_coordinates(destination_id)
        static_map(coordinates, polyline)
    end


    # Google Directions API
    def self.directions(origin_id, destination_id)
        url = URI.encode("https://maps.googleapis.com/maps/api/directions/json?origin=place_id:#{origin_id}&destination=place_id:#{destination_id}&mode=walking&key=" + ENV['googleapikey'])
        print(url)
        data = JSON.load(open(url))
        data['routes'][0]['overview_polyline']['points']
    end
end
