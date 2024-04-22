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
    @customer = Customer.find(params[:id])
    # 退会処理のロジックをここに記述
    @customer.update(is_active: false)
    reset_session  # セッションのリセット（ログアウト）
    redirect_to root_path, notice: "退会処理が完了しました。"
  end

  private

  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :email, :postal_code, :address, :telephone_number, :password, :password_confirmation)
  end

  # ゲストログインの記述
  def prevent_guest_access(action_name, message)
    if current_customer.guest?
      redirect_to public_customer_path(current_customer), alert: message
    end
  end

  # アクションごとに異なる制限を設定
  def edit
    prevent_guest_access('edit', 'ゲストユーザーはプロフィール編集画面へ遷移できません。')
    # 編集に関する処理
  end

  def withdraw
    prevent_guest_access('withdraw', 'ゲストユーザーの退会はできません。')
    # 退会に関する処理
  end
end
