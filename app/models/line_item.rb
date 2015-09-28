class LineItem < ActiveRecord::Base
  belongs_to :product
  belongs_to :cart
  belongs_to :order


  def total_price
    product.local_price * quantity
  end

end
