require('minitest/autorun')
require('minitest/rg')
require_relative('../karaoke_bar')
require_relative('../guest')
require_relative('../room')
require_relative('../song')

class TestGuest < Minitest::Test

def setup
  @guest1 = Guest.new("Delbert Grady", 100, "It's All Forgotten Now")
  @guest3 = Guest.new("Jack Torrance", 10, "Masquerade")
  @song1 = Song.new(0, "Angels", "Robbie Williams", "angels.jpg")
  @song2 = Song.new(1, "It's All Forgotten Now", "Ray Noble and His Orchestra", "forgotten.jpg")
  @song3 = Song.new(2, "Masquerade", "Jack Hylton and His Orchestra", "masquerade.jpg")
  @song4 = Song.new(3, "The Ace of Spades", "Motorhead", "aceofspades.jpg")
  @playlist = [@song1, @song2, @song4]

end # end setup

def test_guest_get_name
  assert_equal("Delbert Grady", @guest1.name)
end

def test_guest_check_wallet
  assert_equal(100, @guest1.check_wallet)
end

def test_guest_get_favourite_song
  assert_equal("It's All Forgotten Now", @guest1.get_favourite_song)
end

def test_guest_pay_entry_fee
  @guest1.pay(10)
  assert_equal(90, @guest1.check_wallet)
end

def test_check_playlist
  p @guest1.check_playlist_for_favourite(@playlist)
end

def test_check_playlist__not_there
  p @guest3.check_playlist_for_favourite(@playlist)
end

end # end class
