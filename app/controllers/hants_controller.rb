class HantsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_hant, except: :create

  def create
    @hant = current_user.hants.build(hant_params)
    if @hant.save
      if locale == :ja
        flash[:success] = "スペースがハントされました"
      else
        flash[:success] = "The space was hanted!"
      end
      redirect_to root_url
    else
      render 'welcome/index'
    end
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
    params.require(:hant).permit(:one_phrase, :content, :study_evaluation, :pc_evaluation)
  end
end
