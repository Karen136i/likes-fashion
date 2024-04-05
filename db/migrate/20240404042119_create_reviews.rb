class CreateReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :reviews do |t|
      
      t.integer :customer_id, null: false
      t.integer :item_id, null: false
      t.text :review_content, null: false
      t.float :star, null: false
      t.timestamps
    end
  end
end
