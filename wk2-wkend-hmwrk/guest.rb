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

end # end class
