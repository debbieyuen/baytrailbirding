# frozen_string_literal: true

require 'faraday'
require 'json'

# Helper for communicating with the Ebird REST API
module EbirdHelper
  include ActionView::Helpers::NumberHelper
  def get_bird_data(lat, lng, radius)
    ebird_params = {  lat: number_with_precision(lat, precision: 2),
                      lng: number_with_precision(lng, precision: 2),
                      back: 10,
                      dist: radius }

    url = 'https://api.ebird.org/v2/data/obs/geo/recent/'

    resp = Faraday.get(url) do |req|
      req.params = ebird_params
      req.headers = { 'X-eBirdApiToken' => '3nt7houcf01l' }
    end

    body = resp.body

    body = JSON.parse(body)

    birds = select_random_birds(body, body.length)

    birds.select { |bird| bird['howMany'].to_i > 1 }.map { |bird| format_bird(bird, get_img_src(bird['comName'],bird['sciName'])) }
  end

  def get_hotspot_bird_data(hotspot)
    ebird_params = {
      back: 10
    }

    url = "https://api.ebird.org/v2/data/obs/#{hotspot}/recent/"

    resp = Faraday.get(url) do |req|
      req.params = ebird_params
      req.headers = { 'X-eBirdApiToken' => '3nt7houcf01l' }
    end

    body = resp.body

    body = JSON.parse(body)

    birds = select_random_birds(body, body.length)

    birds.map { |bird| format_bird(bird) }
  end

  def get_hotspot_data(lat, lng, radius)
    ebird_params = {  lat: number_with_precision(lat, precision: 2),
                      lng: number_with_precision(lng, precision: 2),
                      back: 10,
                      dist: radius,
                      fmt: 'json' }

    url = 'https://api.ebird.org/v2/ref/hotspot/geo'

    resp = Faraday.get(url) do |req|
      req.params = ebird_params
      req.headers = { 'X-eBirdApiToken' => '3nt7houcf01l' }
    end

    body = resp.body

    hotspots = JSON.parse(body)

    hotspots.map { |hotspot| format_hotspot(hotspot) }
  end

  def format_bird(bird, image)
    {
      # Identifiers
      "speciesCode": bird['speciesCode'],
      "subId": bird['subId'],
      # Name data
      "name": {
        "sci": bird['sciName'],
        "com": bird['comName']
      },
      # Location data
      "loc": {
        "id": bird['locId'],
        "name": bird['locName'],
        "lat": bird['lat'],
        "lng": bird['lng'],
        "private": bird['locationPrivate']
      },
      # Observation data
      "obs": {
        "date": bird['obsDt'],
        "cnt": bird['howMany'],
        "valid": bird['obsValid'],
        "reviewed": bird['obsReviewed']
      },
      #Image name
      "img": {
        "img": image
      }
    }
  end

  def format_hotspot(hotspot)
    {
      "loc": {
        "id": hotspot['locId'],
        "name": hotspot['locName'],
        "lat": hotspot['lat'],
        "lng": hotspot['lng']
      },
      "code": {
        "country": hotspot['countryCode'],
        "subnat1": hotspot['subnational1Code'],
        "subnat2": hotspot['subnational2Code']
      },
      "obs": {
        "date": hotspot['latestObsDt']
      },
      "cnt": hotspot['numSpeciesAllTime']
    }
  end

  # Used to stub for testing
  def select_random_birds(birds, num_ret)
    birds.sample(num_ret)
  end

  # rubocop:disable Metrics/AbcSize
  def hav_distance(geo_a, geo_b, miles = false)
    # Get latitude and longitude
    lat1, lon1 = geo_a
    lat2, lon2 = geo_b

    # Calculate radial arcs for latitude and longitude
    d_lat = (lat2 - lat1) * Math::PI / 180
    d_lon = (lon2 - lon1) * Math::PI / 180

    a = Math.sin(d_lat / 2) *
        Math.sin(d_lat / 2) +
        Math.cos(lat1 * Math::PI / 180) *
        Math.cos(lat2 * Math::PI / 180) *
        Math.sin(d_lon / 2) * Math.sin(d_lon / 2)

    c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a))

    6371 * c * (miles ? 1 / 1.6 : 1)
  end
  # rubocop:enable Metrics/AbcSize

  def get_img_src(common_name, scientific_name)
    img_src = nil
    begin
      img_src = get_img_from_name(common_name)
    rescue NoMethodError
      begin
        img_src = get_img_from_name(scientific_name)
      rescue NoMethodError => e
        puts(e)
      end
    end
    img_src
  end

  def get_img_from_name(name)
    # check cache for bird name
    wikimedia_params = {
      action: 'query',
      prop: 'pageimages',
      format: 'json',
      piprop: 'original',
      titles: name,
      redirects: 1
    }

    resp = Faraday.get('https://en.wikipedia.org/w/api.php') do |req|
      req.params = wikimedia_params
    end

    body = resp.body
    image_data = JSON.parse(body)

    image_pages = image_data['query']['pages']
    first_page = image_pages[image_pages.keys[0]]
    first_page['original']['source']

    # put bird name and image into cache
  end
end
