require 'faraday'
require 'json'
include ActionView::Helpers::NumberHelper

module EbirdHelper
  def getBirdData(lat, lng, radius)
    ebird_params = {  :lat => number_with_precision(lat, precision: 2),
                      :lng => number_with_precision(lng, precision: 2),
                      :back => 10,
                      :dist => radius,
                    }

    url = "https://api.ebird.org/v2/data/obs/geo/recent/"

    resp = Faraday.get(url) do |req|
      req.params = ebird_params
      req.headers = {"X-eBirdApiToken" => "3nt7houcf01l"}
    end

    body = resp.body

    body = JSON.parse(body)

    birds = select_random_birds(body, body.length())

    birds.select{ |bird| bird["howMany"].to_i > 1 }.map{ |bird| format_bird(bird, lat, lng) }

  end

  def getHotspotBirdData(hotspot)
    ebird_params = {
                      :back => 10,
                    }

    url = "https://api.ebird.org/v2/data/obs/#{hotspot}/recent/"

    resp = Faraday.get(url) do |req|
      req.params = ebird_params
      req.headers = {"X-eBirdApiToken" => "3nt7houcf01l"}
    end

    body = resp.body

    body = JSON.parse(body)

    birds = select_random_birds(body, body.length())

    birds.map{ |bird| format_bird(bird, 0.to_f, 0.to_f) }

  end

  def getHotspotData(lat, lng, radius)
    ebird_params = {  :lat => number_with_precision(lat, precision: 2),
                      :lng => number_with_precision(lng, precision: 2),
                      :back => 10,
                      :dist => radius,
                      :fmt => "json"
                    }

    url = "https://api.ebird.org/v2/ref/hotspot/geo"

    resp = Faraday.get(url) do |req|
      req.params = ebird_params
      req.headers = {"X-eBirdApiToken" => "3nt7houcf01l"}
    end

    body = resp.body

    hotspots = JSON.parse(body)

    return hotspots.map{|hotspot| format_hotspot(hotspot)}

  end

  def format_bird(bird, lat, lng)
    {
      # Identifiers
      "speciesCode": bird["speciesCode"],
      "subId": bird["subId"],
      # Name data
      "name": {
        "sci": bird["sciName"],
        "com": bird["comName"]
      },
      # Location data
      "loc": {
        "id": bird["locId"],
        "name": bird["locName"],
        "lat": bird["lat"],
        "lng": bird["lng"],
        "private": bird["locationPrivate"],
        "dist": number_with_precision(hav_distance([lat, lng], [bird["lat"], bird["lng"]], true), precision: 1)
      },
      # Observation data
      "obs": {
        "date": bird["obsDt"],
        "cnt": bird["howMany"],
        "valid": bird["obsValid"],
        "reviewed": bird["obsReviewed"]
      },
      # Get the image
      # TODO: Cache this image data so that we don't need to requery wikipedia, you could probably use an id of the species code
      #"img": getImageSrc(bird)
      "img": nil
    }
  end

  def format_hotspot(hotspot)
    {
      "loc": {
        "id": hotspot["locId"],
        "name": hotspot["locName"],
        "lat": hotspot["lat"],
        "lng": hotspot["lng"]
      },
      "code": {
        "country": hotspot["countryCode"],
        "subnat1": hotspot["subnational1Code"],
        "subnat2": hotspot["subnational2Code"]
      },
      "obs": {
        "date": hotspot["latestObsDt"]
      },
      "cnt": hotspot["numSpeciesAllTime"]
    }
  end

  #need to make new function to stub it dumb hate this
  def select_random_birds(birds, num_ret)
    birds.sample(num_ret)
  end

  def hav_distance(geo_a, geo_b, miles=false)
    # Get latitude and longitude
    lat1, lon1 = geo_a
    lat2, lon2 = geo_b

    # Calculate radial arcs for latitude and longitude
    dLat = (lat2 - lat1) * Math::PI / 180
    dLon = (lon2 - lon1) * Math::PI / 180


    a = Math.sin(dLat / 2) *
        Math.sin(dLat / 2) +
        Math.cos(lat1 * Math::PI / 180) *
        Math.cos(lat2 * Math::PI / 180) *
        Math.sin(dLon / 2) * Math.sin(dLon / 2)

     c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a))

    d = 6371 * c * (miles ? 1 / 1.6 : 1)
  end

  def getImageSrc(com, sci)
    img_src = 'never set'
    begin
      img_src = getImageFromName(com)
    rescue NoMethodError => e1
      begin
        img_src = getImageFromName(sci)
      rescue NoMethodError => e2
        img_src = nil
      end
    end
    return img_src
  end



  def getImageFromName(name)

    #check cache for bird name
    #Cache should store sciname, comm name, and wikipedia result 
    wikimedia_params = {
      :action => "query",
      :prop => "pageimages",
      :format => "json",
      :piprop => "original",
      :titles => name,
      :redirects => 1
    }


    resp = Faraday.get("https://en.wikipedia.org/w/api.php") do |req|
      req.params = wikimedia_params
    end

    body = resp.body
    image_data = JSON.parse(body)

    image_pages = image_data["query"]["pages"]
    first_page = image_pages[image_pages.keys[0]]
    image_src = first_page["original"]["source"]

    #put bird name and image into cache
    
    return image_src

  end
end
