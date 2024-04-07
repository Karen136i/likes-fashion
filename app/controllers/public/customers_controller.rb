class Public::CustomersController < ApplicationController
  before_action :authenticate_customer! #アクセス制限
  before_action :ensure_guest_user, only: [:edit]
  def show
  end

  def edit
  end

  def unsubscribe
  end
  
  
  
  
  private
  # ゲストログインの記述
  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.email == "guest@example.com"
      redirect_to user_path(current_user) , notice: "ゲストユーザーはプロフィール編集画面へ遷移できません。"
    end
  end  
  
  
end
