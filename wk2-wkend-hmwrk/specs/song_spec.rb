require('minitest/autorun')
require('minitest/rg')
require_relative('../karaoke_bar')
require_relative('../guest')
require_relative('../room')
require_relative('../song')

class TestSong < Minitest::Test

def setup
  @song1 = Song.new(0, "Angels", "Robbie Williams", "angels.jpg")
end # end setup

def test_get_song_title
  p "time using attr_reader"
  assert_equal("Angels", @song1.title)
end

def test_get_song_artist
  assert_equal("Robbie Williams", @song1.artist)
end

def test_get_picture_filename
  assert_equal("angels.jpg", @song1.get_picture_filename)
end

def test_get_song_index_number
  assert_equal(0, @song1.index_number)
end

end # end class
