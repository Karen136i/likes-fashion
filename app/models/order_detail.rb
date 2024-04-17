class OrderDetail < ApplicationRecord
  belongs_to :order
  belongs_to :item
  
  enum shipping_statuses: { 着手不可: 0, 商品準備中: 1, 商品準備完了: 2, 発送済み:3 }

end