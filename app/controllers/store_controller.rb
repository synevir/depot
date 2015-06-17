class StoreController < ApplicationController
  include CurrentCart
  before_action :set_cart


  #------------- variant#4 -------------
#   before_filter :increment_count, only: [:index]


  def index
	@products = Product.order(:title)

	# ------ variant #1 -------------
	@index_vizit = increment_count


	# ------ variant #2 -------------
#     session[:counter] || 0
#     @index_vizit = session[:counter] += 1

	# ------ variant #3 -------------
# 	  @counter = session[:counter]
#     @counter.nil? ? @counter = 1 : @counter+=1
#     session[:counter] = @counter

	#-------- variant #4 --------------
#  	  @index_vizit = session[:counter]

  end



#   private

	# ------ variant # 1 & 4(extension)  -------------
    def increment_count
	# variant #1.1  во время первого открытия страницы выдает ошибку
# 		            undefined method `+' for nil:NilClass (вторая строка функции)
#         session[:counter] || 0
#         session[:counter] += 1

# variant #1.2
   	  if session[:counter].nil?
   		session[:counter] = 0
   	  end
   	  session[:counter] += 1

# variant #1.3
#      (session[:counter].nil?) ? (session[:counter] = 1) : (session[:counter] +=1)
#     session[:counter].nil? ? session[:counter] = 1 : session[:counter] +=1
    end

end
