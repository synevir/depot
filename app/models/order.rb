class Order < ActiveRecord::Base
  has_many :line_items, dependent: :destroy

  PAYMENT_TYPES = [ "Check", "Credit card", "Purchase order" ]

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

  validates :name, :address, :email, presence: true
  validates :email, format: { with: VALID_EMAIL_REGEX }, allow_blank: true
  validates :address, :name, length: { minimum: 2 },     allow_blank: true
  validates :pay_type, inclusion: PAYMENT_TYPES

  def add_line_items_from_cart(cart)
    cart.line_items.each do |item|
      item.cart_id = nil
      line_items << item
    end
  end

  def order_sum
	line_items.to_a.sum { |item| item.total_price }
  end



end
