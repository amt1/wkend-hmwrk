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

end # end class
