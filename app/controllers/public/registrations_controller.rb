class Public::RegistrationsController < ApplicationController
   before_action :configure_sign_up_params, only: [:create,:update]
   before_action :authenticate_customer!

  def after_sign_up_path_for(resource)
    public_customers_path
  end
 
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys:[:last_name, :first_name, :last_name_kana, :first_name_kana, :telephone_number, :postal_code, :address])
  end
  
end
