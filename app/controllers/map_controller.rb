class MapController < ApplicationController
  before_action :authenticate_user!

  def index
    @spaces = Space.all
    @hash = Gmaps4rails.build_markers(@spaces) do |space, marker|
      marker.lat space.latitude
      marker.lng space.longitude
      marker.infowindow space.description
      marker.json({title: space.title})
    end
  end

  def search
    render 'hant'
  end

  def hant
  end
end
