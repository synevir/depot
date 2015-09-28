module OrdersHelper

  def index_by
    inject({}) {|hash, elem| hash.merge!(yield(elem) => elem) }
  end


  def payment_type_options
#   локализация списка платежных средств
#   options_for_select(Hash [ Order::PAYMENT_TYPES.map {|x| 
#                       [ I18n.t('orders.payment_types.' + x.parameterize.underscore), x ] } ] )
    options_for_select( PaymentType.all.collect{|p_t|
	                     [I18n.t('orders.payment_types.' + p_t.name.parameterize.underscore),  p_t.id]})
  end


  def paymentTypeIdToString(id)
#   конвертация id платежного средства в строку для отображения в представлениях
    if id.nil?
      return 'n/a'
    else
      return PaymentType.find(id).name
    end
  end

end


