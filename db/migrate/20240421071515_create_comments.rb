class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      
      t.integer :review_id, null: false
      t.integer :admin_id, null:false
      t.text :comment, null: false
      t.timestamps
    end
  end
end
