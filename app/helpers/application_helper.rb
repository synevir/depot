module ApplicationHelper
  def hidden_div_if(condition, attributes = {}, &block)
    if condition
      attributes["style"] = "display: none"
    end
    content_tag("div", attributes, &block)
  end

  RATE_EURO = 0.9
  RATE_UAH  = 22
  def currency_rate(price)
	return case I18n.locale.to_s
           when 'en' then price
           when 'es' then price * RATE_EURO
           when 'ua' then price * RATE_UAH
           else price
           end
  end

end
