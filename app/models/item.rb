class Item < ApplicationRecord
  require 'miyabi'

  enum status: { on_sale: 0, not_on_sale: 1, back_ordered: 2 }
  has_one_attached :image
  belongs_to :category
  has_many :cart_items
  has_many :favorites, dependent: :destroy
  has_many :reviews, dependent: :destroy

  validates :price, presence: true, numericality: { only_integer: true }
  validates :name, presence: true, length: { maximum: 20 }
  validates :image, presence: true
  validates :introduction, presence: true, length: { maximum: 70 }

  def price_without_tax
    tax_rate = 0.1
    (price * (1 - tax_rate)).round
  end

  def self.get_all_conversions(content)
    [
      content,
      content.to_hiragana,
      content.to_katakana,
      content.to_roman,
    ].uniq
  end

  def self.search_for(content)
    # デバッグ出力
    Rails.logger.info "Searching for: #{content}"

    # 変換結果を取得
    converted_contents = get_all_conversions(content)

    # 変換結果のデバッグ出力
    Rails.logger.info "Converted contents: #{converted_contents.join(', ')}"

    # 検索クエリを生成
    queries = converted_contents.map do |converted_content|
      "name LIKE '%#{converted_content}%'"
    end.join(" OR ")

    # 検索クエリのデバッグ出力
    Rails.logger.info "Search queries: #{queries}"

    # 検索を実行
    Item.where(queries)
  end

  scope :latest, -> { order(created_at: :desc) }
  scope :old, -> { order(created_at: :asc) }
  scope :star_count, -> { order(star: :desc) }

  def average_rating
    reviews.average(:star).to_f.round(2)
  end
end
