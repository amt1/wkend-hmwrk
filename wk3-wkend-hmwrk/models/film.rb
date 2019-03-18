require_relative('../db/sqlrunner.rb')
require_relative('./customer.rb')
require_relative('./ticket.rb')

class Film

  attr_accessor :title, :price
  attr_reader :id

  def initialize(options)
    @title = options['title']
    @price = options['price']
    @id = options['id'].to_i if options['id']
  end

  def save
      sql = "INSERT INTO films (title, price) VALUES ($1, $2) RETURNING id;"
      values = [@title, @price]
      returned_id = SqlRunner.run(sql, values).first['id']
      @id = returned_id.to_i
  end

  def self.map_my_films(films_hash)
    return films_hash.map { |film| Film.new(film)  }
  end

  def self.list_all
          sql = "SELECT * FROM films"
          films_hash = SqlRunner.run(sql)
      return map_my_films(films_hash)
  end

  def self.delete_all
    sql = "DELETE FROM films"
    SqlRunner.run(sql)
  end

  def delete
      sql = "DELETE FROM films WHERE id = $1;"
      values = [@id]
      SqlRunner.run(sql, values)
  end

  def update(options)
        sql = 'UPDATE films SET (title, price) = ($1, $2) WHERE id = $3;'
           values = [options['title'], options['price'], @id]
          SqlRunner.run(sql, values)
  end
  def list_customers
    sql = 'SELECT * FROM customers
  INNER JOIN tickets ON customers.id = tickets.customer_id
  INNER JOIN films ON tickets.film_id = films.id
  WHERE films.id = $1;'
    values = [@id]
    customers_hash = SqlRunner.run(sql, values)
    return Customer.map_my_customers(customers_hash)
  end

  def list_customers_by_name
    sql = 'SELECT name FROM customers
  INNER JOIN tickets ON customers.id = tickets.customer_id
  INNER JOIN films ON tickets.film_id = films.id
  WHERE films.id = $1;'
    values = [@id]
    customer_list = SqlRunner.run(sql, values)
    return customer_list.map { |customer| customer['name'] }
  end

  def count_customers
    customer_count = 0
    sql = 'SELECT COUNT(DISTINCT customer_id) FROM tickets WHERE film_id = $1;'
    values = [@id]
    customer_count = SqlRunner.run(sql,values).first['count']
    return customer_count.to_i
  end

def find_bestselling_time
#     sql = 'SELECT films.id, MAX(number_of_seats - tickets_available) tickets_sold, films.title
# FROM screenings
# INNER JOIN films
# ON screenings.film_id = films.id
# AND films.id = $1
# GROUP BY films.id;'  # stuck with adding screening time to columns to select. Error:
# #ERROR:  column "screenings.time" must appear in the GROUP BY clause or be used in an aggregate function
# LINE 1: ...s - tickets_available) tickets_sold, films.title, screenings...
# revisiting earlier approach:
sql = ' SELECT screenings.*, films.title, number_of_seats - tickets_available AS "tickets_sold"
  FROM screenings
  INNER JOIN films ON screenings.film_id = films.id
  AND films.id = $1
  ORDER BY films.title, tickets_sold DESC;'
    values = [@id]
    screenings_hash = SqlRunner.run(sql, values)
    my_map = screenings_hash.map { |listing| [listing['time'],listing['title'],listing['tickets_sold'].to_i]}
    return my_map
  end
def display_bestselling_time
screenings_array = find_bestselling_time
soldmore = 0
screenings_array.each do |screening|
  sold = screening[2]
  if soldmore <= sold
    p "#{screening[0]}: #{screening[1]}, Sold: #{sold}"
    soldmore = sold
  else
    return
  end
end
end

end # end class
