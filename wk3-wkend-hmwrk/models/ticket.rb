require_relative('../db/sqlrunner.rb')

class Ticket

  attr_reader :id, :customer_id, :film_id

  def initialize(options)
    @customer_id = options['customer_id']
    @film_id = options['film_id']
    @id = options['id'].to_i if options['id']
    @customer = get_customer
  end

  def get_customer
    sql = "SELECT * FROM customers WHERE id = $1;"
    values = [@customer_id]
    my_customer = Customer.new(SqlRunner.run(sql,values).first)
    return my_customer
  end

  def sell
    msg = "Sale not completed"
    if @customer.buy_ticket(@film_id)
      save
      msg = "Sale successful, enjoy the film!"
    end
    return msg
  end

  def save
      sql = "INSERT INTO tickets (customer_id, film_id) VALUES ($1, $2) RETURNING id;"
      values = [@customer_id, @film_id]
      returned_id = SqlRunner.run(sql, values).first['id']
      @id = returned_id.to_i
  end

  def self.map_my_tickets(tickets_hash)
    return tickets_hash.map { |ticket| Ticket.new(ticket)  }
  end

  def self.list_all
          sql = "SELECT * FROM tickets"
          tickets_hash = SqlRunner.run(sql)
      return map_my_tickets(tickets_hash)
  end

  def self.delete_all
    sql = "DELETE FROM tickets"
    SqlRunner.run(sql)
  end

  def delete
      sql = "DELETE FROM tickets WHERE id = $1;"
      values = [@id]
      SqlRunner.run(sql, values)
  end

  def update(options)
        sql = 'UPDATE tickets SET (customer_id, film_id) = ($1, $2) WHERE id = $3;'
           values = [options['customer_id'], options['film_id'], @id]
          SqlRunner.run(sql, values)
  end

end # end class
