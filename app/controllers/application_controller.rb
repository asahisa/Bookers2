class ApplicationController < ActionController::Base
  ## コントローラ実行前に処理
  before_action :configure_permitted_parameters, if: :devise_controller?

  ## サインイン後のリダイレクト先
  def after_sign_in_path_for(resource)
    user_path(params[:id])
  end

  ## サインアウト後のリダイレクト先
  def after_sign_out_path_for(resource)
    new_user_session_path
  end

  ## 他コントローラからも参照
  protected

  def configure_permitted_parameters
    ## ユーザー登録時, nameデータ操作を許可
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
end
