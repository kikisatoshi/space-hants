class HantsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_hant, only: [:destroy]

  def index
    redirect_to controller: 'spaces', action: 'index'
  end

  def create
    @hant = current_user.hants.build(hant_params)
    @hant.study_evaluation = 0 if @hant.study_evaluation.blank?
    @hant.pc_evaluation = 0 if @hant.pc_evaluation.blank?
    if @hant.save
      flash[:success] = t('js.reviewed', default: 'You reviewed.')
      redirect_to controller: 'spaces', action: 'show', id: @hant.space_id
    else
      flash.now[:danger] = t('js.failed_review', default: 'You failed to review.')
      @space = Space.find(@hant.space_id)
      @hants = Hant.where(space_id: @space.id).order(created_at: :desc)
      @hash = Gmaps4rails.build_markers(@space) do |space, marker|
        marker.lat space.latitude
        marker.lng space.longitude
        marker.title space.title
        marker.json({title: space.title})
      end
      render 'spaces/show'
    end
  end

  def destroy
    @hant.destroy
    flash[:success] = t('js.review_deleted', default: 'Review was deleted.')
    redirect_to controller: 'spaces', action: 'show', id: @hant.space_id
  end

  private
  def set_hant
    if Hant.exists?(:id => params[:id])
      @hant = Hant.find(params[:id])
    else
      redirect_to request.referrer || root_url
    end
  end

  def hant_params
    params.require(:hant).permit(:one_phrase, :content, :study_evaluation,
      :pc_evaluation, :space_id, :user_id)
  end
end
