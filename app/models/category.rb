class Category < ApplicationRecord
  has_many :items, dependent: :destroy  # 依存関係も考慮
  validates :name, presence: true, uniqueness: { case_sensitive: false }, length: { maximum: 20, message: "カテゴリー名は20文字以内で入力してください" }
end
