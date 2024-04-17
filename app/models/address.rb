class Address < ApplicationRecord
    belongs_to :customer
    
  #全て空でないこと
   validates :postal_code, :address, :name, presence: true
 
   def full_address
    '〒' + postal_code + ' ' + address + ' ' + name
   end
    
end
