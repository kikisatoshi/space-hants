class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:show]

  def index
    redirect_to root_url
  end

  def show
    @spaces = @user.spaces.order(created_at: :desc)
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
