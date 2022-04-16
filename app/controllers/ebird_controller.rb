require 'net/http'
require 'json'
include ActionView::Helpers::NumberHelper
include EbirdHelper

class EbirdController < ApplicationController
  def birds #This route is called whenever the page is loaded -- loads in all the markers 
    lat = params[:lat].to_f
    lng = params[:lng].to_f
    radius = (params[:radius] || 50).to_i
    hotspot = params[:hotspot]
    birds = []
    if hotspot
      birds = getHotspotBirdData(hotspot);
    else
      birds = getBirdData(lat, lng, radius);
    end
    render :json => birds
  end
  def bird #This will load in data for an individual bird
    sci = params[:sci]
    com = params[:com]
    img = getImageSrc(com, sci)
    render :json => {
      :img => img
    }  
  end
  def hotspots
    lat = params[:lat].to_f
    lng = params[:lng].to_f
    radius = (params[:radius] || 50).to_i
    hotspots = getHotspotData(lat, lng, radius);
    render :json => hotspots
  end
end
