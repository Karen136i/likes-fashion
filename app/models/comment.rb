class Comment < ApplicationRecord
  # モデルの関連付けやバリデーションがここに記述される
  belongs_to :review
  belongs_to :admin
end