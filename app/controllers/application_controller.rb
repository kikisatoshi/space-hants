class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # URLのパラメータでlocaleを判定
  before_filter :set_locale

  # jaだったらリンク名なし。それ以外ならリンク名にenとかをセットする。
  def default_url_options(options={})
    { locale: I18n.locale == I18n.default_locale ? nil : I18n.locale }
  end

  # リンクの多言語化に対応する
  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end
end
