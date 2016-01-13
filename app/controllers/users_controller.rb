class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:show]

  def index
    redirect_to root_url
  end

  def show
    if params[:type] == "Favorite"
      space_ids =  @user.favorites.order(created_at: :desc).pluck(:space_id)
      @spaces = Array.new
      space_ids.each do |space_id|
        @spaces << Space.find(space_id)
      end
      @spaces = Kaminari.paginate_array(@spaces).page(params[:page])
    elsif params[:type] == "Review"
      @hants = @user.hants.order(created_at: :desc).page(params[:page])
    else
      @spaces = @user.spaces.order(created_at: :desc).page(params[:page])
    end
  end

  private
  def set_user
    if User.exists?(:id => params[:id])
      @user = User.find(params[:id])
    else
      redirect_to request.referrer || root_url
    end
  end
end
