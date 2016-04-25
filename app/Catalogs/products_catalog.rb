class ProductsCatalog < Prawn::Document
  # ширина колонок
  Widths = [85, 160, 55, 240]

  # заглавия колонок
  Headers = ['Дата добавления', 'Title', '', 'Description']

  # папка с картинками
  Image_dir = "./app/assets/images/"

  # содержимое таблицы и форматирование ячеек
   def row(date, title, description, image_path)
     picture = Image_dir + image_path
     row = [date, title, {:image => picture, :image_width => 50,
                          :image_height => 70},
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
         :normal => "#{font_dir}/VerdanaRegular.ttf" })
   end

  # генерируем pdf
  def to_pdf
    load_fonts()
    font "Verdana", :size => 10
    text "Каталог за #{Time.zone.now.strftime('%b %Y')}", :size => 15, :style => :bold, :align => :center
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

end

