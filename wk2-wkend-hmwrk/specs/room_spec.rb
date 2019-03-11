require('minitest/autorun')
require('minitest/rg')
require_relative('../karaoke_bar')
require_relative('../guest')
require_relative('../room')
require_relative('../song')

class TestRoom < Minitest::Test

def setup
  @room1 = Room.new("The Colorado Lounge", 2)
  @guest1 = Guest.new("Delbert Grady", 100, "It's All Forgotten Now")
  @guest2 = Guest.new("Danny Torrance", 1, "Angels")
  @song1 = Song.new(0, "Angels", "Robbie Williams", "angels.jpg")
  @song2 = Song.new(1, "It's All Forgotten Now", "Ray Noble and His Orchestra", "forgotten.jpg")
  @song3 = Song.new(2, "Masquerade", "Jack Hylton and His Orchestra", "masquerade.jpg")
  @song4 = Song.new(3, "The Ace of Spades", "Motorhead", "aceofspades.jpg")
  @playlist = [@song1, @song2, @song4]
  @room1.load_playlist(@playlist)
end # end setup

# def test_room_name
#   assert_equal("The Colorado Lounge", @room1.name)
# end
#
# def test_room_capacity
#   assert_equal(2, @room1.capacity)
# end
#
# def test_add_guest_to_room
#   @room1.add_guest(@guest1)
#   assert_equal(@guest1, @room1.get_guest_list[0])
# end
#
# def test_is_guest_in_room
#   @room1.add_guest(@guest1)
#   assert_equal(true, @room1.is_guest_in_room(@guest1.name))
#   assert_equal(false, @room1.is_guest_in_room(@guest2.name))
# end
#
# def test_remove_guest_from_room
#   @room1.add_guest(@guest2)
#    @room1.remove_guest(@guest2.name)
#    assert_equal(false, @room1.is_guest_in_room(@guest2.name))
#
# end
#
# def test_add_song_to_room
#   @room1.add_song_to_playlist(@song1)
#   assert_equal(@song1, @room1.get_song_list[0])
# end
#
# def test_is_room_full
#   assert_equal(false, @room1.is_full)
#   @room1.add_guest(@guest1)
#   @room1.add_guest(@guest2)
#   assert_equal(true, @room1.is_full)
# end
#
# def test_load_playlist
# #  @room1.load_playlist(@playlist)
#   assert_equal(@playlist, @room1.get_song_list)
# end
#
#
# def test_is_song_in_room_playlist
#   assert_equal(true, @room1.is_song_in_playlist(@song1.title, @song1.artist))
#   assert_equal(false, @room1.is_song_in_playlist(@song3.title, @song3.artist))
# end

# def test_check_guest_tab
#   @room1.add_guest(@guest1)
#   p "Tab: "
#  p @room1.check_tab(@guest1)
# end

# def test_add_to_guest_tab
#   @room1.add_guest(@guest1)
#   @room1.add_to_tab(@guest1.name,50)
#   assert_equal(50, @room1.check_tab(@guest1.name))
# end

def test_sell_to_guest_with_tab__enough_money
  @room1.add_guest(@guest1)
  @room1.sell_to_guest_tab(@guest1,50)
  assert_equal(50, @room1.check_tab(@guest1.name))
end

def test_sell_to_guest_with_tab__not_enough_money
  @room1.add_guest(@guest1)
  @room1.sell_to_guest_tab(@guest1,500)
  assert_equal(0, @room1.check_tab(@guest1.name))
end

def test_delete_tab
  @room1.add_guest(@guest1)
    @room1.delete_tab(@guest1)
    assert_nil(@room1.check_tab(@guest1.name))
#    p @room1.check_tab(@guest1.name)
end

end # end class
