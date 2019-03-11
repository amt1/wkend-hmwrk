class Room

attr_reader :name, :capacity

def initialize(name, capacity)
  @name = name
  @guests = []
  @capacity = capacity
  @songs=[]
  @guest_tabs={}
end

def get_guest_list
  return @guests
end

def add_guest(guest)
  @guests << guest
  @guest_tabs[guest.name] = 0
  guest.check_playlist_for_favourite(@songs)
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

def load_playlist(playlist)
  playlist.each { |song| add_song_to_playlist(song)}
end

def is_song_in_playlist(song_title, artist)
  return @songs.any? { |song| song.title== song_title && song.artist == artist}
end

def is_full
  return (@guests.count() >= @capacity) ? true : false
end

def check_tab(guest_name)
  return @guest_tabs[guest_name]
end

def add_to_tab(guest_name, price)
  @guest_tabs[guest_name] += price
# @guest_tabs[guest] = 50
end

def sell_to_guest_tab(guest, price)
  if guest.check_wallet > (price + check_tab(guest.name))
    add_to_tab(guest.name, price)
    return true
  else
    p "Your money's no good here. But... we think you have management potential..."
    return false
  end
end

def delete_tab(guest)
  @guest_tabs.delete_if { |guest_name, amount| guest_name==guest.name}
end

end # end class
