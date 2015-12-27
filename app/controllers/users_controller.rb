class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    redirect_to root_url
  end
end
