Product.delete_all
    Product.create!(title: 'Programming Ruby 1.9 & 2.0',
      description:
	%{<p>
	Ruby is the fastest growing and most exciting dynamic language
	out there. If you need to get working programs delivered fast,
	you should add Ruby to your toolbox.
	</p>},
      image_url: 'ruby.jpg',
      price: 49.95)




    Product.create!(title: 'Dizin traveling!',
      description:
	%{Dizin is a most butifull land in Asia!
	Skying wait for your!
	
	</p>},
      image_url: 'dizin.jpg',
      price: 300)