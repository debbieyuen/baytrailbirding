# frozen_string_literal: true

require 'rails_helper'
require 'vcr'

RSpec.describe 'Ebirds', type: :request do
  it 'given coords, it returns nearby birds' do
    VCR.use_cassette('ebird/get_bird_from_cords') do
      get '/ebird/birds', params: { lat: 37.42, lng: -121.91, radius: 25 }
      expect(response.content_type).to eq('application/json; charset=utf-8')
    end
  end

  it 'given coords, it returns nearby hotspots' do
    VCR.use_cassette('ebird/get_hotspot_from_coords') do
      get '/ebird/hotspots', params: { lat: 37.42, lng: -121.91, radius: 25 }
      expect(response.content_type).to eq('application/json; charset=utf-8')
    end
  end

  it 'given hotspot, it returns the birds for that hotspot' do
    VCR.use_cassette('ebird/get_birds_from_hotspot') do
      get '/ebird/birds', params: { hotspot: 'L6530472' }
      expect(response.content_type).to eq('application/json; charset=utf-8')
    end
  end

  it 'Returns all images' do
    VCR.use_cassette('locations/fixed_ip') do
      loc = Location.find_or_initialize_by(name: 'Example Location')
      loc.update(description: 'Lorem Ipsum Dolor Dot', latitude: '37.8716', longitude: '-122.2728',
                 short_desc: 'Lorem Ipsdum Dolor Dot', picURL: 'www.google.com')
      loc.save
      get '/ebird/locations', params: {}, headers: { "REMOTE_ADDR": '67.170.238.57' }

      # TODO: Can't figure out how to match the updated date correctly.
    end
  end

  it 'given bird common and scientific name, it returns the bird image' do
    VCR.use_cassette('ebird/get_image_from_name') do
      get '/ebird/bird', params: { com: 'Canada Goose', sci: 'Branta canadensis' }
      expect(response.content_type).to eq('application/json; charset=utf-8')
    end
  end

  it 'given wrong scientific and common name, it does not return a bird' do
    VCR.use_cassette('ebird/getBirdData') do
      VCR.use_cassette('ebird/getImageSrc') do
        get '/ebird/bird', params: { sci: 'Hello', com: "Doesn't exist", radius: 25 }
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end
  end
end
