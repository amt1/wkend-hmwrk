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
  @song1 = Song.new(0, "Angels", "Robbie Williams", "angels.jpg")
  @song2 = Song.new(1, "It's All Forgotten Now", "Ray Noble and His Orchestra", "forgotten.jpg")
  @song3 = Song.new(2, "Masquerade", "Jack Hylton and His Orchestra", "masquerade.jpg")
  @song4 = Song.new(3, "The Ace of Spades", "Motorhead", "aceofspades.jpg")
  @playlist = [@song1, @song2, @song4]
  @room1.load_playlist(@playlist)
  @karaokebar1 = KaraokeBar.new("The Overlook Karaoke", 10, @all_rooms)
end # end setup

def test_check_in_all_ok_check_money
  @karaokebar1.check_in(@guest1, @room1)
  assert_equal(1010, @karaokebar1.check_till)
  assert_equal(90, @guest1.check_wallet)
end

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

def test_close_tab
  @room1.add_guest(@guest1)
  @room1.sell_to_guest_tab(@guest1,50)
  @karaokebar1.close_tab(@room1, @guest1)
  assert_nil(@room1.check_tab(@guest1))
end

def test_check_out_guest
  @room1.add_guest(@guest2)
  assert_equal(true, @karaokebar1.check_out_guest(@room1, @guest2))
end

end # end class
