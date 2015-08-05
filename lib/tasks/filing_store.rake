namespace :db do
  desc "Add to database products"
  task create_admin: :environment do
	product1 = Product.create!(
	  title:       "Let us C++ ",
      description: "language C with objects ",
	  image_url:   "Cpp.jpg",
	  price:        0.1,
      details:     "ISBNN 5-272-656566565656 602стр. Издательство Питер"
	)

    product2 = Product.create!(
	  title:       "Ruby on Rails 4",
      description: "Rails 4. Гибкая разработка веб-приложений (Серия «Для профессионалов»)",
	  image_url:   "rails.png",
	  price:        20,
      details:     "ISBN 978-5-496-00898-3
	                © Перевод на русский язык ООО Издательство «Питер», 2014
                    © Издание на русском языке, оформление ООО Издательство «Питер», 20"
	)

	product3 = Product.create!(
	  title:       "Turbo Pascal",
      description: "The old program language with strict typisation.",
	  image_url:   "TurboPascal.jpg",
	  price:        21,
      details:     "Borland Pascal v.7.1  -1995"
	)

	product4 = Product.create!(
	  title:       "Администрирование IIS",
      description: "Администрирование сервера IIS-7 Автор: Крис Адамс",
	  image_url:   "iis7.jpg",
	  price:        25.4,
      details:     "ISBN 978-5-9518-0367-2, 978-1-59749-155-6; 2010 г.переводчик: А. Караваев"
	)

  end
end
