require('minitest/autorun')
require('minitest/rg')
require_relative('../karaoke_bar')
require_relative('../guest')
require_relative('../room')
require_relative('../song')

class TestGuest < Minitest::Test

def setup
  @guest1 = Guest.new("Delbert Grady", 100, "It's All Forgotten Now")
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

end # end class
