class Public::SessionsController < Devise::SessionsController
  
  before_action :configure_sign_in_params, only: [:create]
  before_action :reject_customer, only: [:create]  # ログインプロセス前に退会ユーザーのチェックを追加
  
  def after_sign_in_path_for(resource)
     root_path
  end

  def after_sign_out_path_for(resource)
     root_path
  end
  
  # ゲストログイン
  def guest_sign_in
    customer = Customer.guest
    sign_in customer
    redirect_to root_path, notice: "gues tuserでログインしました。"
  end

  # ログアウト後のリダイレクト先
  private
  
  def after_sign_out_path_for(resource)
     about_path
  end

  def configure_sign_in_params
     devise_parameter_sanitizer.permit(:sign_in, keys: [:email, :password])
  end

  def reject_customer
    user_email = params[:customer][:email] 
    customer = Customer.find_by(email: user_email)
    if customer && customer.valid_password?(params[:customer][:password])
      if customer.is_deleted
        flash[:alert] = "退会済みです。再度ご登録をしてご利用ください"
        redirect_to new_customer_registration_path and return
      end 
    else 
      flash[:alert] = "該当するユーザーが見つかりません"
      redirect_to new_customer_session_path
    end 
  end

end