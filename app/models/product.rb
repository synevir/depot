class Product < ActiveRecord::Base
  validates_presence_of :title,
					message: "Поле заголовка должно быть заполнено!"

  validates :description, :image_url, presence: true

  validates :price, numericality: { greater_than_or_equal_to: 0.01,
                    message: "Цена не может быть меньше 0,01."
					}

  validates :title, uniqueness: true,
		  length: { minimum: 10, too_short:
                    "Название должно иметь не менее %{count} символов."
         }

  validates :image_url, allow_blank: true, format: {
					with: %r{\.(gif|jpg|png)\Z}i,
					message: 'URL must be GIF, JPG or PNG format.'
  }

#   для кеширования товаров, которые были изменены
  def self.latest
    Product.order(:updated_at).last
  end


end

