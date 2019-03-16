require_relative('./models/customer.rb')
require_relative('./models/film.rb')
require_relative('./models/ticket.rb')

Ticket.delete_all
Customer.delete_all
Film.delete_all

# Film functions

film1 = Film.new({'title' => 'The Godfather', 'price' => '5'})
film2 = Film.new({'title' => 'Alien', 'price' => '8'})
film3 = Film.new({'title' => 'Being John Malkovich', 'price' => '10'})

film1.save
film2.save
film3.save

p Film.list_all

film1.update({'title' => 'When Harry Met Sally', 'price' => film1.price})
p Film.list_all

film3.delete
p Film.list_all

# Customer functions:

customer1 = Customer.new({'name' => 'Stanley', 'funds' => '20'})
customer2 = Customer.new({'name' => 'Rolf', 'funds' => '10'})
customer3 = Customer.new({'name' => 'Tommy', 'funds' => '5'})
customer4 = Customer.new({'name' => 'Redshirt', 'funds' => '2'})

customer1.save
customer2.save
customer3.save
customer4.save
p Customer.list_all

customer3.update({'name' => customer3.name, 'funds' => '200'})
p Customer.list_all

customer4.delete
p Customer.list_all

# Ticket functions:

ticket1 = Ticket.new({'customer_id' => customer1.id, 'film_id' => film1.id})
ticket2 = Ticket.new({'customer_id' => customer2.id, 'film_id' => film2.id})
ticket3 = Ticket.new({'customer_id' => customer3.id, 'film_id' => film1.id})
ticket4 = Ticket.new({'customer_id' => customer3.id, 'film_id' => film2.id})

ticket1.save
ticket2.save
ticket3.save
ticket4.save
p Ticket.list_all

p customer3.list_films
p customer3.list_films_by_title

ticket4.delete
p Ticket.list_all

ticket2.update({'customer_id' => customer2.id, 'film_id' => film1.id})
p Ticket.list_all

p film1.list_customers
p film1.list_customers_by_name
