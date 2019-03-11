class Song

attr_reader :title, :artist, :index_number
# this is faster than getter methods
def initialize(index_number, title, artist, pic_filename)
  @title = title
  @artist = artist
  @pic_filename = pic_filename
  @index_number = index_number
end

def get_picture_filename
  return @pic_filename
end

# other getter methods, not needed

def get_song_title
  return @title
end

def get_song_artist
  return @artist
end

def get_index_number
  return @index_number
end

end # end class
