class OrdersController < ApplicationController
  include CurrentCart
  skip_before_action :authorize, only: [:new, :create]

  before_action :set_cart, only: [:new, :create]
  before_action :set_order, only: [:show, :edit, :update, :destroy]

  # GET /orders
  # GET /orders.json
  def index
    @orders = Order.search(params[:search])
  end

  def show
  end

  # GET /orders/new
  def new
    if @cart.line_items.empty?
      redirect_to store_url, notice: "Your cart is empty"
      return
    end

	@order = Order.new
	@hide_button_checkout = true
  end

  # GET /orders/1/edit
  def edit
  end


  def create
    @order = Order.new(order_params)
	@order.add_line_items_from_cart(@cart)

    respond_to do |format|
      if @order.save
		Cart.destroy(session[:cart_id])
        session[:cart_id] = nil
		OrderNotifier.received(@order).deliver_now		#отправка почтового уведомления
        format.html { redirect_to store_url, notice: I18n.t('.thanks')  }
        format.json { render :show, status: :created, location: @order  }
      else
#  		@cart = current_cart
        format.html { render :new, notice: "current order not save, render :new" }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
# -------------------------------------------------------
#  после обновления заказа отправляем письмо об отправке
#--------------------------------------------------------
	    @order.ship_date = DateTime.now
	    OrderNotifier.shipped(@order).deliver_now
# ---------------------------------------------------------
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_order
      @order = Order.find(params[:id])
    end

    def order_params
      params.require(:order).permit(:name, :address, :email, :pay_type)
    end
end
