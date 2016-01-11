class HantsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_hant, only: [:destroy]

  def index
    redirect_to root_url
  end

  def create
    @hant = current_user.hants.build(hant_params)
    @hant.study_evaluation = 0 if @hant.study_evaluation.blank?
    @hant.pc_evaluation = 0 if @hant.pc_evaluation.blank?
    if @hant.save
      flash[:success] = t('js.reviewed', default: 'You reviewed.')
    else
      flash[:danger] = t('js.failed_review', default: 'You failed to review. Please enter comment.')
    end
    redirect_to @hant.space
  end

  def destroy
    @hant.destroy
    flash[:success] = t('js.review_deleted', default: 'Review was deleted.')
    redirect_to @hant.space
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
    params.require(:hant).permit(:content, :study_evaluation,
      :pc_evaluation, :space_id, :user_id)
  end
end
