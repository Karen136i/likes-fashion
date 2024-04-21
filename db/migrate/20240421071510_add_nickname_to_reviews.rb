class AddNicknameToReviews < ActiveRecord::Migration[6.1]
  def change
    add_column :reviews, :nickname, :string
  end
end
