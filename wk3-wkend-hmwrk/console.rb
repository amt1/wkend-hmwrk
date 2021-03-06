require('pry-byebug')
require_relative('./models/customer.rb')
require_relative('./models/film.rb')
require_relative('./models/ticket.rb')
require_relative('./models/screening.rb')

Ticket.delete_all
Customer.delete_all
Film.delete_all
Screening.delete_all

# Film functions

film1 = Film.new({'title' => 'The Godfather', 'price' => '5'})
film2 = Film.new({'title' => 'Alien', 'price' => '8'})
film3 = Film.new({'title' => 'Wonder', 'price' => '10'})

film1.save
film2.save
film3.save

# p Film.list_all

film1.update({'title' => 'When Harry Met Sally', 'price' => film1.price})
# p Film.list_all

# film3.delete
# p Film.list_all

# Customer functions:

customer1 = Customer.new({'name' => 'Stanley', 'funds' => '2'})
customer2 = Customer.new({'name' => 'Rolf', 'funds' => '10'})
customer3 = Customer.new({'name' => 'Tommy', 'funds' => '5'})
customer4 = Customer.new({'name' => 'Redshirt', 'funds' => '2'})

customer1.save
customer2.save
customer3.save
customer4.save
# p Customer.list_all

customer3.update({'name' => customer3.name, 'funds' => '200'})
# p Customer.list_all

customer4.delete
# p Customer.list_all

# Ticket functions:

ticket1 = Ticket.new({'customer_id' => customer1.id, 'film_id' => film1.id})
ticket2 = Ticket.new({'customer_id' => customer2.id, 'film_id' => film2.id})
ticket3 = Ticket.new({'customer_id' => customer3.id, 'film_id' => film1.id})
ticket4 = Ticket.new({'customer_id' => customer3.id, 'film_id' => film2.id})
ticket5 = Ticket.new({'customer_id' => customer3.id, 'film_id' => film1.id})

# ticket1.save
# ticket2.save
# ticket3.save
# ticket4.save
# ticket5.save
# p ticket1.sell
# p ticket2.sell
# p ticket3.sell
# # p Ticket.list_all

# p customer3.list_films
# p customer3.list_films_by_title

# ticket4.delete
# p Ticket.list_all

# ticket2.update({'customer_id' => customer2.id, 'film_id' => film1.id})
# p Ticket.list_all

# p film1.count_customers
# p film1.list_customers
# p film1.list_customers_by_name
#
# p customer1.count_tickets
# p customer3.count_tickets

# Screening functions

screening1 = Screening.new({'film_id' => film1.id, 'time' => '10:00', 'tickets_available' => 200, 'number_of_seats' => 200})
screening1.save
screening2 = Screening.new({'film_id' => film1.id, 'time' => '13:00', 'tickets_available' => 20, 'number_of_seats' => 200})
screening2.save
screening3 = Screening.new({'film_id' => film2.id, 'time' => '16:00', 'tickets_available' => 2, 'number_of_seats' => 200})
screening3.save
screening4 = Screening.new({'film_id' => film3.id, 'time' => '16:00', 'tickets_available' => 200, 'number_of_seats' => 200})
screening4.save
screening5 = Screening.new({'film_id' => film2.id, 'time' => '13:00', 'tickets_available' => 20, 'number_of_seats' => 200})
screening5.save
screening6 = Screening.new({'film_id' => film3.id, 'time' => '10:00', 'tickets_available' => 2, 'number_of_seats' => 200})
screening6.save
screening7 = Screening.new({'film_id' => film3.id, 'time' => '13:00', 'tickets_available' => 200, 'number_of_seats' => 200})
screening7.save
screening8 = Screening.new({'film_id' => film2.id, 'time' => '10:00', 'tickets_available' => 20, 'number_of_seats' => 200})
screening8.save
screening9 = Screening.new({'film_id' => film1.id, 'time' => '16:00', 'tickets_available' => 20, 'number_of_seats' => 200})
screening9.save

# Screening.display_all_screenings
# p Screening.list_all_screening_times
# Screening.display_order_bestselling_times

film1.display_bestselling_time

film2.display_bestselling_time

film3.display_bestselling_time
# binding.pry
# nil
