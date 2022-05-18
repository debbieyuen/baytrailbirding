# frozen_string_literal: true

# Handles rendering pages that do not use the Ebird API
class ApplicationController < ActionController::Base
  include EbirdHelper

  def show
    calc_location
    @locations_full = Location.all.sort_by do |location|
      hav_distance([location.latitude.to_f, location.longitude.to_f], @current_location)
    end
  end
end
