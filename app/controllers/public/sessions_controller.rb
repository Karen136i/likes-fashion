# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  before_action :configure_sign_in_params, only: [:create]
  
  def after_sign_in_path_for(resource)
     root_path
  end

  def after_sign_out_path_for(resource)
     root_path
  end

  # ログアウト後のリダイレクト先
  private
  def after_sign_out_path_for(resource)
     root_path
  end


  def configure_sign_in_params
     devise_parameter_sanitizer.permit(:sign_in, keys: [:email, :password])
  end


 def reject_end_user
     @end_user = EndUser.find_by(email: params[:end_user][:email])
     if @end_user
       if @end_user.valid_password?(params[:end_user][:password]) && (@end_user.is_deleted == true)
         flash[:notice] = "退会済みです。再度ご登録をしてご利用ください"
         redirect_to new_end_user_registration_path
       else
         flash[:notice] = "項目を入力してください"
       end
     else
       flash[:notice] = "該当するユーザーが見つかりません"
     end
 end
end


  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
