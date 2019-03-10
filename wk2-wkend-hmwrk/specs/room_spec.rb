require('minitest/autorun')
require('minitest/rg')
require_relative('../karaoke_bar')
require_relative('../guest')
require_relative('../room')
require_relative('../song')

class TestRoom < Minitest::Test

def setup
  @room1 = Room.new("The Colorado Lounge", 10)
  @guest1 = Guest.new("Delbert Grady", 100, "It's All Forgotten Now")
  @guest2 = Guest.new("Danny Torrance", 1, "Angels")
  @song1 = Song.new("Angels", "Robbie Williams", "angels.jpg", 0)
  @song2 = Song.new("It's All Forgotten Now", "Ray Noble and His Orchestra", "forgotten.jpg", 1)

end # end setup

def test_room_name
  assert_equal("The Colorado Lounge", @room1.name)
end

def test_room_capacity
  assert_equal(10, @room1.capacity)
end

def test_add_guest_to_room
  @room1.add_guest(@guest1)
  assert_equal(@guest1, @room1.get_guest_list[0])
end

def test_is_guest_in_room
  @room1.add_guest(@guest1)
  assert_equal(true, @room1.is_guest_in_room(@guest1.name))
  assert_equal(false, @room1.is_guest_in_room(@guest2.name))

end

def test_remove_guest_from_room
  @room1.add_guest(@guest2)
   @room1.remove_guest(@guest2.name)
   assert_equal(false, @room1.is_guest_in_room(@guest2.name))

end

def test_add_song_to_room
  @room1.add_song_to_playlist(@song1)
  assert_equal(@song1, @room1.get_song_list[0])
end

# def test_is_song_in_room_playlist
#   @room1.add_song_to_playlist(@song1)
#   assert_equal(true, @room1.is_song_in_playlist(@song1.name, @song1.artist))
#   assert_equal(false, @room1.is_song_in_playlist(@song2.name, @song2.artist))
# end

end # end class
