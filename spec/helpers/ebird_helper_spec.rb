require 'rails_helper'
require 'vcr'

# Specs in this file have access to a helper object that includes
# the EbirdHelper. For example:
#
# describe EbirdHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe EbirdHelper, type: :helper do
  describe "getBirdData" do
    it "given coords, it returns a nearby bird" do
      VCR.use_cassette('ebird/get_bird_from_cords') do
        lat = 37.42.to_f
        lng = -121.91.to_f
        bird = getBirdData(lat,lng,25).first;
        expect(hav_distance([lat,lng],[bird[:loc][:lat],bird[:loc][:lng]],true)).to be <= 25
      end
    end
  end
  describe "getImageSrc" do
    it "given data with a common name, returns an image" do
      VCR.use_cassette('ebird/get_image_src/common_name') do
        com = "Canada Goose"
        sci = "Branta canadensis"
        image = getImageSrc(com, sci);
        expect(image).to eq "https://upload.wikimedia.org/wikipedia/commons/4/40/Canada_goose_on_Seedskadee_NWR_%2827826185489%29.jpg"
      end
    end
    it "given data with a scientific name, returns an image" do
      VCR.use_cassette('ebird/get_image_src/scientific_name') do
        com = "Sora"
        sci = "porzana carolina"
        image = getImageSrc(com, sci);
        expect(image).to eq "https://upload.wikimedia.org/wikipedia/commons/2/2d/Sora_%28Porzana_carolina%29.jpg"
      end
    end
    it "given data with ambiguous names, returns no image" do
      VCR.use_cassette('ebird/get_image_src/ambiguous_names') do
        com = "Common x Barrow's Goldeneye (hybrid)"
        sci = "Bucephala clangula x islandica"
        image = getImageSrc(com, sci);
        expect(image).to eq nil
      end
    end
  end
  describe "getImageFromName" do
    it "given name, it returns an image" do
      VCR.use_cassette('ebird/get_image_from_name') do
        name = "Canada Goose"
        image = getImageFromName(name);
        expect(image).to eq "https://upload.wikimedia.org/wikipedia/commons/4/40/Canada_goose_on_Seedskadee_NWR_%2827826185489%29.jpg"
      end
    end
  end
end
