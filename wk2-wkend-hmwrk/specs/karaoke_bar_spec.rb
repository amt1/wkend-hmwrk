require('minitest/autorun')
require('minitest/rg')
require_relative('../karaoke_bar')
require_relative('../guest')
require_relative('../room')
require_relative('../song')

class TestKaraokeBar < Minitest::Test

def setup
  @room1 = Room.new("The Colorado Lounge", 2)
  @room2 = Room.new("The Gold Ballroom", 200)
  @room3 = Room.new("Room 237", 2)
  @room4 = Room.new("The Hedge Maze", 3)
  @all_rooms=[@room1, @room2, @room3, @room4]
  @guest1 = Guest.new("Delbert Grady", 100, "It's All Forgotten Now")
  @guest2 = Guest.new("Danny Torrance", 1, "Angels")
  @guest3 = Guest.new("Jack Torrance", 10, "Masquerade")
  @song1 = Song.new("Angels", "Robbie Williams", "angels.jpg", 0)
  @song2 = Song.new("It's All Forgotten Now", "Ray Noble and His Orchestra", "forgotten.jpg", 1)
  @karaokebar1 = KaraokeBar.new("The Overlook Karaoke", 10, @all_rooms)
end # end setup

def test_guest_check_in__no_money
  assert_equal(false, @karaokebar1.check_in(@guest2, @room2))
end

def test_guest_check_in__enough_money
  assert_equal(true, @karaokebar1.check_in(@guest1, @room2))
end

def test_guest_check_in__room_full
  @room1.add_guest(@guest2)
  assert_equal(true, @karaokebar1.check_in(@guest3, @room1))
  assert_equal(false, @karaokebar1.check_in(@guest1, @room1))
end

def test_find_room_with_spaces
  @room1.add_guest(@guest1)
  @room1.add_guest(@guest3)
  available_rooms = @karaokebar1.find_room_with_spaces
  assert_equal([@room2.name, @room3.name, @room4.name], available_rooms)
end


end # end class
