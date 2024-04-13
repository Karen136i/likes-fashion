class Public::CustomersController < ApplicationController
  before_action :authenticate_customer! #アクセス制限
  before_action :ensure_guest_user, only: [:edit]
  def show
    @customer = Customer.find(current_customer.id)
    
  end

  def edit
    @customer = Customer.find(current_customer.id)
  end
  
  def update
     @customer = Customer.find(current_customer.id)
     if @customer.update(customer_params)
        redirect_to public_customer_path, notice: "登録情報が更新されました。"
     else
        render :edit
     end 
  end

  def unsubscribe
  end
  
  def withdraw
    @customer = Customer.find(current_customer.id)
    @customer.update(is_deleted: true, is_active: false)
    reset_session
    flash[:notice] = "退会処理を実行しました。"
    redirect_to root_path
  end 
  
  
  private
  
  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :email, :postal_code, :address, :telephone_number, :password, :password_confirmation)
  end  
  
  # ゲストログインの記述
  def ensure_guest_user
    if current_customer.email == "guest@example.com"
      redirect_to public_customer_path(current_customer), notice: "ゲストユーザーはプロフィール編集画面へ遷移できません。"
    end
  end
  
  
end
