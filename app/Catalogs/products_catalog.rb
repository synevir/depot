class ProductsCatalog < Prawn::Document
  include ActionView::Helpers::SanitizeHelper

  # ширина колонок в каталоге
  Widths = [85, 160, 55, 240]

  # заглавия колонок
  Headers = ['Date Added', 'Title', '', 'Description']

  # папка с картинками
  Image_dir = "./app/assets/images/"

  # содержимое таблицы и форматирование ячеек каталога
   def row(date, title, description, image_path)
     picture = Image_dir + image_path
     row = [date, title, {:image => picture, :image_width => 50,
                          :image_height => 70},
#             удаление html тегов не сработало
#             description.strip_tags ]
#             description.sanitize ]
#             strip_tags(description) ]
             description ]


     make_table([row]) do |t|
       t.column_widths = Widths
       t.cells.style :borders => [:left, :right], :padding => 3
     end
   end

  # привязываем кирилитические шрифты
   def load_fonts()
     font_dir = "#{Rails.root}/app/assets/fonts"
     font_families.update(
       "Verdana" => {
         :bold => "#{font_dir}/VerdanaBold.ttf",
         :italic => "#{font_dir}/VerdanaItalic.ttf",
         :normal => "#{font_dir}/VerdanaRegular.ttf" },

       "TimeRoman" => {
         :italic => "#{font_dir}/TimeRomanItalic.ttf",
         :normal => "#{font_dir}/TimeRomanRegular.ttf" },

       "AntiqTitulRegular" => {
         :normal => "#{font_dir}/AntiqTitulRegular.ttf" })
   end

  # генерируем pdf каталог
  def to_pdf
    load_fonts()
    font "Verdana", :size => 10
    text "#{Time.zone.now.strftime('%b %Y')} products catalog", :size => 15, :style => :bold, :align => :center
    move_down(18)

    # выборка записей
    @products = Product.order('created_at')
    data = []
    products = @products.each do |prod|
      data << row(prod.created_at.strftime('%d/%m/%y'), prod.title,
                  prod.description, prod.image_url)
    end

    # отрисовка таблицы
    head = make_table([Headers], :column_widths => Widths,
                      :cell_style => {:align => :center})
    table([[head], *(data.map{|d| [d]})], :header => true,
           :row_colors => %w[cccccc ffffff]) do
             row(0).style :background_color => '000000', :text_color => 'ffffff'
             cells.style :borders => []
           end

    # время создания внизу страницы
    creation_date = Time.zone.now.strftime("Каталог сгенерирован %e %b %Y в %H:%M")
    go_to_page(page_count)
    move_down(700)
    horizontal_rule
    stroke
    move_down(10)
    text creation_date, :align => :right, :style => :italic, :size => 9
    render
  end



# -----------------------------------------------------------------------------------------------
# генерируем буклет
# -----------------------------------------------------------------------------------------------

# Ширина колонок в буклете
  Width_booklets_columns = [180, 360]
  Cover_size_small       = [80, 170]
  Cover_size_normal      = [160, 340]
  Padding_in_cell        = 10
  Default_style = {:background_color => "dddddd", :padding => Padding_in_cell}


  def to_pdf_booklet
    load_fonts()
    font "Verdana", :size => 15, :style => :bold, :align => :left
    text("Pragmatic Bookshelf \'2016 ", :size => 28)
    image(Image_dir + 'logo.png', :at => [455, 722], :scale => 0.7)
    horizontal_rule
    stroke
    move_down 2
    horizontal_rule
    stroke
    move_down 30

    @products = Product.order('created_at')
    @products.each do |product|
      img = Image_dir + product.image_url
# размер масштабирования в зависимости от расширения
      File.extname(img) == '.png' ? img_fit = Cover_size_small : img_fit = Cover_size_normal

      cell_title = make_cell(:content => product.title, :colspan => 2,
                             :padding => Padding_in_cell,
                             :font => "AntiqTitulRegular",
                             :font_style => :normal,
                             :size => 16)
      cell_desc = make_cell(:content => product.description,
                            :font => "TimeRoman",
                            :font_style => :italic,
                            :size => 14
                           )
      cell_price = make_cell(:content => "Price: $ #{product.price}",
                             :size => 12, :colspan => 2 )
      cell_empty = make_cell(:content => "", :size => 10, :colspan => 2)

      table([[cell_title],
           [{:image => img, :fit => img_fit}, cell_desc],
           [cell_price],
           [cell_empty]],
           :cell_style => Default_style,
           :column_widths => Width_booklets_columns
         ) do
        rows(0..3).each{|r| r.borders =[]}
        row(1).borders = [:top]
      end
      move_down 25

      if(cursor < 200 )
        start_new_page
        text("Pragmatic Bookshelf \'2016 ", :size => 14)
        image(Image_dir + 'logo.png', :at => [492, 720], :scale => 0.4)
        horizontal_rule
        stroke
        move_down 2
        horizontal_rule
        stroke
        move_down 20
      end

    end

#      font("TimeRoman", :style => :normal)
     string = "page <page>"
     options = { :at => [bounds.right - 150, 0],
              :width => 150,
              :align => :right,
              :page_filter => (1..7),
              :start_count_at => 1,
              :size => 14,
              :color => "0000000" }
#      начало отображения номерации с определенной страницы
#      options[:page_filter]    = lambda{ |pg| pg > 1 }
     number_pages string, options


#     product = Product.first
#     img = Image_dir + product.image_url
#     cell_title = make_cell(:content => product.title, :colspan => 2,
#                            :padding => Padding_in_cell)
#     cell_desc = make_cell(:content => product.description,
#                           :font => "Times-Roman",
#                           :font_style => :italic,
#                           :size => 14
#                          )
#     cell_price = make_cell(:content => "Price: $ #{product.price}",
#                            :size => 10, :colspan => 2 )
#     cell_empty = make_cell(:content => "", :size => 10, :colspan => 2)
#
#     table([[cell_title],
#            [{:image => img, :scale => 0.9}, cell_desc],
#            [cell_price],
#            [cell_empty]],
#            :cell_style => Default_style,
#            :column_widths => Width_booklets_columns
#          ) do
#
#       row(0).borders = [:top]
#       rows(1..3).each{|r| r.borders =[]}
#     end
    render
  end

end

# модернизация базового класса `string` для обработки строк
class String
#   def sanitize
#     ActionController::Base.helpers.sanitize(self)
#   end

#   def strip_tags
#     ActionController::Base.helpers.strip_tags(self)
#   end
end

