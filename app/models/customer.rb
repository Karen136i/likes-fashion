class Customer < ApplicationRecord
  require 'miyabi'

  def active_for_authentication?
    Rails.logger.info "Called active_for_authentication?: is_deleted = #{is_deleted}"
    super && !is_deleted
  end

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :favorites, dependent: :destroy
  has_many :review_favorites, dependent: :destroy
  has_many :cart_items
  has_many :addresses
  has_many :orders
  has_many :reviews

  validates :last_name, :first_name, :last_name_kana, :first_name_kana, :email, :encrypted_password, :telephone_number, :postal_code, :address, presence: true

  GUEST_USER_EMAIL = "guest@example.com"

  def self.guest
    find_or_create_by!(email: GUEST_USER_EMAIL) do |customer|
      customer.password = SecureRandom.urlsafe_base64
      customer.last_name = "guest"
      customer.first_name = "user"
      customer.last_name_kana = "ゲスト"
      customer.first_name_kana = "ユーザー"
      customer.postal_code = "0000000"
      customer.telephone_number = "00000000000"
      customer.address = "ゲスト"
    end
  end

  def guest?
    email == GUEST_USER_EMAIL
  end

  # 検索ボックスの記述
  def self.get_all_conversions(content)
    [
      content,
      content.to_hiragana,
      content.to_katakana,
      content.to_roman,
      content.to_kanhira
    ].uniq
  end

  def self.search_for(content)
    converted_contents = get_all_conversions(content)

    queries = converted_contents.map do |converted_content|
      "(CONCAT(last_name, first_name) LIKE '%#{converted_content}%' OR email LIKE '%#{converted_content}%')"
    end.join(" OR ")
    
    # 検索クエリのデバッグ出力
    # Rails.logger.info "Search queries: #{queries}"

    Customer.where(queries)
  end
  # ここまで
end
