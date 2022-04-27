require 'rails_helper'
require 'vcr'

RSpec.describe "Ebirds", type: :request do
  it "given coords, it returns an image for a nearby bird" do
    VCR.use_cassette('ebird/get_image_from_name') do
      VCR.use_cassette('ebird/get_bird_from_cords') do

        get "/ebird/birds", :params => { :lat => 37.42, :lng => -121.91, :radius => 25}
        expect(response.content_type).to eq("application/json; charset=utf-8")
        expect(response.parsed_body().first[:img]).to eq(nil)

      end
    end


    #expect(response.content_type).to eq("application/json")

    end
end
