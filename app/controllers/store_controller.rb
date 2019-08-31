class StoreController < ApplicationController
  include CurrentCart
  skip_before_action :authorize
  before_action :set_cart

#   require Prawn

  def index
#   @products = Product.order(:title)              // first version  `simple`
#   @products = Product.search(params[:search])    // second ver. before i18n 
    if params[:set_locale]
      redirect_to store_url(locale: params[:set_locale])
    else
      @products = Product.order(:title)
    end
  end



  def download_pdf
    output = ProductsCatalog.new.to_pdf
    send_data( output,:type => 'application/pdf',
                      :filename => "products.pdf",
                      :disposition => "inline")
  end


  def downloadPdfBooklet
    output = ProductsCatalog.new.to_pdf_booklet
    send_data( output,:type => 'application/pdf',
                      :filename => "products_booklet.pdf",
                      :page_size => "A4",
                      :disposition => "inline")
  end


end
