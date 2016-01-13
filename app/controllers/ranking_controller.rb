class RankingController < ApplicationController
  before_action :authenticate_user!

  def cafe
    fav_space_ids = Favorite.group(:space_id).order('count_all desc').count.keys
    @spaces = []
    cafes = Space.where(category: 'cafe')
    fav_space_ids.each do |fav_space_id|
      @spaces << cafes.find(fav_space_id) if cafes.exists?(fav_space_id)
    end
    @spaces = Kaminari.paginate_array(@spaces).page(params[:page])
  end

  def library
    fav_space_ids = Favorite.group(:space_id).order('count_all desc').count.keys
    @spaces = []
    libraries = Space.where(category: 'library')
    fav_space_ids.each do |fav_space_id|
      @spaces << libraries.find(fav_space_id) if libraries.exists?(fav_space_id)
    end
    @spaces = Kaminari.paginate_array(@spaces).page(params[:page])
  end

  def original
    fav_space_ids = Favorite.group(:space_id).order('count_all desc').count.keys
    @spaces = []
    originals = Space.where(category: 'original')
    fav_space_ids.each do |fav_space_id|
      @spaces << originals.find(fav_space_id) if originals.exists?(fav_space_id)
    end
    @spaces = Kaminari.paginate_array(@spaces).page(params[:page])
  end
end
