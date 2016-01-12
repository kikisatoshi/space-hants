class OwnershipsController < ApplicationController
  before_action :authenticate_user!

  def create
    @space = Space.find(params[:space_id])
    if params[:type] == "Favorite"
      current_user.favorite(@space)
    else
      current_user.report(@space)
      if @space.reporting_users.count > @space.favorite_users.count + 10
        @space.destroy
        if @space.hants.present?
          @space.hants.destroy_all
        end
        flash[:danger] = t('js.space_deleted_by_report')
      else
        flash[:success] = t('js.reported')
      end
      redirect_to @space
    end
  end

  def destroy
    @space = Space.find(params[:space_id])
    if params[:type] == "Favorite"
      current_user.unfavorite(@space)
    else
      current_user.unreport(@space)
    end
  end
end
