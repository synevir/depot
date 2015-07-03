module OrdersHelper

	def index_by
	  inject({}) {|hash, elem| hash.merge!(yield(elem) => elem) }
	end

  def payment_type_options
	#options_for_select(Hash [*(Order::PAYMENT_TYPES.map{|x| [x.id, x] }).flatten ] )
array = Order::PAYMENT_TYPES
	  hash = array.inject({}) {|hash, obj| hash[obj.id] = obj }
	  hash = Hash[*(array.map {|obj| [obj.id, obj]}).flatten]
  end

end
