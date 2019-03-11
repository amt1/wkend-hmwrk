class Guest

attr_reader :name

def initialize(name, wallet, favourite_song)
  @name = name
  @wallet = wallet
  @favourite_song = favourite_song
end

def check_wallet
  return @wallet
end

def get_favourite_song
  return @favourite_song
end

def pay(amount)
  @wallet -= amount
end

def check_playlist_for_favourite(playlist)
  if playlist.any? { |song| song.title == @favourite_song}
    p "#{@name}: Woohoo, they've got my favourite song, #{@favourite_song}! "
    return true
  end
  p "#{@name}: Boo hoo, they haven't got my favourite song"
  return false
end

end # end class
