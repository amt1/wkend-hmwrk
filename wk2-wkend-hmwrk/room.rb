class Room

attr_reader :name, :capacity

def initialize(name, capacity)
  @name = name
  @guests = []
  @capacity = capacity
  @songs=[]
end

def get_guest_list
  return @guests
end

def add_guest(guest)
  @guests << guest
end

def is_guest_in_room(guest_name)
  return @guests.any? { |guest| guest.name==guest_name }
end

def remove_guest(guest_name)
  @guests.delete_if {|guest| guest.name==guest_name}
end

def add_song_to_playlist(song)
  @songs << song
end

def get_song_list
  return @songs
end

end # end class
