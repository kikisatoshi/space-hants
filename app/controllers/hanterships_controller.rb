class HantershipsController < ApplicationController
  before_action :authenticate_user!

  def create
    @hant = Hant.find(params[:hant_id])
    current_user.like(@hant)
  end

  def destroy
    @hant = current_user.hanterships.find(params[:id]).hant
    current_user.unlike(@hant)
  end
end
