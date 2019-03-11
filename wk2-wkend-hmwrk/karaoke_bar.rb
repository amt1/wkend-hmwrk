class KaraokeBar

attr_reader :name, :entry_fee

def initialize(name, entry_fee, rooms)
  @name = name
  @till = 1000
  @entry_fee = entry_fee
  @rooms = rooms
end

def check_in(guest, room)
  checked_in = false
  message = ""
  if room.is_full
    message += "Sorry, #{room.name} is full. "
    available_rooms = find_room_with_spaces()
    counter = available_rooms.count()
    if counter > 0
      message += "We do have spaces in "
      while counter >= 2 do
        message +=  "#{available_rooms.pop()}, "
        counter -=1
        message +=  "and " if (counter == 1)
      end
        message +=  "#{available_rooms[0]}"
    else
      message +=  "All our rooms are full right now"
    end
  else
    if guest.check_wallet >= @entry_fee
      guest.pay(@entry_fee)
      receive_money(@entry_fee)
      message += "Welcome to #{@name}, #{guest.name}. "
      message += "Please follow the signs to #{room.name}. "
      room.add_guest(guest)
      checked_in = true
    else
      message +=  "Sorry, #{guest.name}, it's #{@entry_fee} to get in and you don't have enough money"
    end
  end
  p message if message.length > 0
  return checked_in
end
# there's probably a shorter way of doing this

def find_room_with_spaces
  available_rooms = Array.new()
  available_rooms = @rooms
  .find_all { |room| room.is_full == false}
  .map { |room| room.name  }
  return available_rooms
end

def receive_money(amount)
  @till += amount
end

def check_till
  return @till
end

def close_tab( room, guest)
    amount_owing = room.check_tab(guest.name)
    guest.pay(amount_owing)
    receive_money(amount_owing)
    room.delete_tab(guest)
end

def check_out_guest(room, guest)
  close_tab(room, guest)
  room.remove_guest(guest)
  p "#{guest.name} is trying to leave but we're correcting them "
  return true if room.is_guest_in_room(guest)== false && room.check_tab(guest.name)== nil
  return false
end

end # end class
