require_relative('../db/sqlrunner.rb')
require_relative('./film.rb')

class Customer

  attr_accessor :name
  attr_reader :id

  def initialize(options)
    @name = options['name']
    @funds = options['funds']
    @id = options['id'].to_i if options['id']
  end

  def save
      sql = "INSERT INTO customers (name, funds) VALUES ($1, $2) RETURNING id;"
      values = [@name, @funds]
      returned_id = SqlRunner.run(sql, values).first['id']
      @id = returned_id.to_i
  end

  def self.map_my_customers(customer_hash)
    return customer_hash.map { |customer| Customer.new(customer)  }
  end

  def self.list_all
          sql = "SELECT * FROM customers"
          customer_hash = SqlRunner.run(sql)
      return map_my_customers(customer_hash)
  end

  def self.delete_all
    sql = "DELETE FROM customers"
    SqlRunner.run(sql)
  end

  def delete
      sql = "DELETE FROM customers WHERE id = $1;"
      values = [@id]
      SqlRunner.run(sql, values)
  end

  def update(options)
        sql = 'UPDATE customers SET (name, funds) = ($1, $2) WHERE id = $3;'
           values = [options['name'], options['funds'], @id]
          SqlRunner.run(sql, values)
  end

  def list_films
    sql = 'SELECT * FROM films
INNER JOIN tickets ON films.id = tickets.film_id
INNER JOIN customers ON customer_id = customers.id
WHERE customers.id = $1;'
    values = [@id]
    films_hash = SqlRunner.run(sql, values)
    return Film.map_my_films(films_hash)
  end

  def list_films_by_title
    sql = 'SELECT title FROM films
  INNER JOIN tickets ON films.id = tickets.film_id
  INNER JOIN customers ON customer_id = customers.id
  WHERE customers.id = $1;'
    values = [@id]
    films_list = SqlRunner.run(sql, values)
    return films_list.map { |film| film['title'] }
  end
end # end class
