class Public::CustomersController < ApplicationController
  before_action :authenticate_customer!
  before_action :ensure_guest_user, only: [:edit, :update, :destroy]

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
    @customer.update(is_active: false)
    reset_session
    redirect_to root_path, notice: "退会処理が完了しました。"
  end

  private

  def ensure_guest_user
    if current_customer.guest?
      redirect_to public_customer_path(current_customer), alert: "ゲストユーザーはこの操作を実行できません。"
    end
  end

  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :email, :postal_code, :address, :telephone_number, :password, :password_confirmation)
  end
end

