require 'test_helper'

class RestaurantTest < ActiveSupport::TestCase

  test "restaurant attributes must not be empty" do
    restaurant = Restaurant.new
    assert restaurant.invalid?
    assert restaurant.errors[:name].any?
    assert restaurant.errors[:location].any?
  end

  test "resturant added with proper attributes" do
    restaurant = Restaurant.new(name: "Campus Pub", location: "123 Wolf Avenue, Atlanta GA, 12345")
    restaurant.valid?
    assert_equal "Campus Pub", restaurant.name
    assert_equal "123 Wolf Avenue, Atlanta GA, 12345", restaurant.location
  end
end
