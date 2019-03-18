require_relative('../db/sqlrunner.rb')
require_relative('./film.rb')
require_relative('./ticket.rb')

class Screening

  attr_reader :id, :film_id, :time, :tickets_available

  def initialize(options)
    @film_id = options['film_id']
    @time = options['time']
    @tickets_available = options['tickets_available'].to_i
    @number_of_seats = options['number_of_seats'].to_i
    @tickets_sold = @number_of_seats - @tickets_available
    @id = options['id'].to_i if options['id']
  end

  def save
      sql = "INSERT INTO screenings (film_id, time, tickets_available, number_of_seats)
      VALUES ($1, $2, $3, $4) RETURNING id;"
      values = [@film_id, @time, @tickets_available, @number_of_seats]
      returned_id = SqlRunner.run(sql, values).first['id']
      @id = returned_id.to_i
  end

  def self.list_all_screening_times
          sql = "SELECT screenings.time, films.title
          FROM screenings
          INNER JOIN films ON screenings.film_id = films.id
          ORDER BY screenings.time, films.title;"
          screenings_hash = SqlRunner.run(sql)
          my_map = screenings_hash.map { |listing|  [listing['time'], listing['title']] }
      return my_map
  end

  def self.display_all_screenings
    screenings_array = list_all_screening_times
    screenings_array.each do |screening|
      p "#{screening[0]}: #{screening[1]}"
    end
  end

  def self.list_order_bestselling_times
    sql = 'SELECT screenings.*, films.title, number_of_seats - tickets_available AS "tickets_sold"
    FROM screenings
    INNER JOIN films ON screenings.film_id = films.id
    ORDER BY films.title, tickets_sold DESC;'
    screenings_hash = SqlRunner.run(sql)
    my_map = screenings_hash.map { |listing|  [listing['time'], listing['title'], listing['tickets_sold']] }
    return my_map
  end

    def self.display_order_bestselling_times
      screenings_array = list_order_bestselling_times
      screenings_array.each do |screening|
        p "#{screening[0]}: #{screening[1]}, Sold: #{screening[2]}"
      end
    end


  def self.delete_all
    sql = "DELETE FROM screenings"
    SqlRunner.run(sql)
  end

end # end class
