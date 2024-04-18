class Customer < ApplicationRecord

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :favorites, dependent: :destroy
  has_many :cart_items
  has_many :addresses
  has_many :orders

  # フォーム内がすべて空じゃないようにする
   validates :last_name, :first_name, :last_name_kana, :first_name_kana, :email, :encrypted_password, :telephone_number, :postal_code, :address, presence: true


  # ゲストログインの記述
  GUEST_USER_EMAIL = "guest@example.com"

  def self.guest
    find_or_create_by!(email: GUEST_USER_EMAIL) do |customer|
      customer.password = SecureRandom.urlsafe_base64 #ランダムな文字列を生成するRubyのメソッドの一種
      customer.last_name = "guest"
      customer.first_name = "user"
      customer.last_name_kana = "ゲスト"
      customer.first_name_kana = "ユーザー"
      customer.postal_code = "0000000"
      customer.telephone_number = "00000000000"
      customer.address = "ゲスト"
    end
  end

  def guest_customer?
    email == GUEST_USER_EMAIL
  end
  # ここまで


  
  # 顧客の検索を行うメソッド
  def self.search_for(content, method)
    case method
    when "perfect"
      # 完全一致
      Customer.where("CONCAT(last_name, first_name) = ?", content)
    when "forward"
      # 前方一致
      Customer.where("CONCAT(last_name, first_name) LIKE ?", "#{content}%")
    when "backward"
      # 後方一致
      Customer.where("CONCAT(last_name, first_name) LIKE ?", "%#{content}")
    when "partial"
      # 部分一致
      Customer.where("CONCAT(last_name, first_name) LIKE ?", "%#{content}%")
    else
      Customer.none
    end
  end


  #ここまで

end
