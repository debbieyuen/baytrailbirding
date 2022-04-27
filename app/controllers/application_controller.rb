class ApplicationController < ActionController::Base
  include EbirdHelper
  def index
    calc_location()
    @locations_full = Location.all.sort_by{|location| hav_distance([location.latitude.to_f, location.longitude.to_f], @current_location)}
  end

  def show
    calc_location()
  	@locations_full = Location.all.sort_by{|location| hav_distance([location.latitude.to_f, location.longitude.to_f], @current_location)}
  end

  def calc_location
    @current_location = [37.8039, -122.2591]
    if IPAddress.valid? request.remote_ip and request.remote_ip != '127.0.0.1'
      user_IP = request.remote_ip
      results = Geocoder.search(user_IP)
      if results.first.coordinates and results.first.coordinates.any?
        @current_location = results.first.coordinates
      end
    end
  end
end
