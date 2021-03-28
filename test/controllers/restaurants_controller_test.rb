require 'test_helper'

class RestaurantsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @restaurant = restaurants(:one)
    @restaurant2 = restaurants(:two)
  end

  test "should get index" do
    get restaurants_url
    assert_select 'h1', 'Split The Check'
    assert_select 'h3', 'Where should we eat next?'
    assert_response :success
  end

  test "should get new" do
    get new_restaurant_url
    assert_select 'h1', 'New Restaurant'
    assert_response :success
  end

  test "should create restaurant" do
    assert_difference('Restaurant.count') do
      post restaurants_url, params: { restaurant: { downvotes: @restaurant.downvotes, location: @restaurant.location, name: @restaurant.name, upvotes: @restaurant.upvotes } }
    end

    assert_redirected_to restaurant_url(Restaurant.last)
  end

  test "should show restaurant" do
    get restaurant_url(@restaurant)
    assert_response :success
  end

  test "should get edit" do
    get edit_restaurant_url(@restaurant)
    assert_response :success
  end

  test "should update restaurant" do
    patch restaurant_url(@restaurant), params: { restaurant: { downvotes: @restaurant.downvotes, location: @restaurant.location, name: @restaurant.name, upvotes: @restaurant.upvotes } }
    assert_redirected_to restaurants_path
  end

  test "should show upvotes" do
    assert_equal(@restaurant.upvotes, 10)
    assert_equal(@restaurant2.upvotes, 1)
  end

  test "should show downvotes" do
    assert_equal(@restaurant.downvotes, 1)
    assert_equal(@restaurant2.downvotes, 10)
  end

  test "should add an upvote" do
    assert_equal(@restaurant.upvotes, 10)

    @restaurant.upvotes += 1

    assert_equal(@restaurant.upvotes, 11)
  end

  test "should add a downvote" do
    assert_equal(@restaurant2.downvotes, 10)

    @restaurant2.downvotes += 1

    assert_equal(@restaurant2.downvotes, 11)
  end

  test "should search for restaurant" do
    post search_path, params: {restaurant: {name: @restaurant.name, location: @restaurant.location}}
    assert_response :success
  end

  test "should redirect after failed searches" do
    post search_path, params: {restaurant: {name: @restaurant.name}}
    assert_redirected_to restaurants_path

    post search_path, params: {restaurant: {name: @restaurant.location}}
    assert_redirected_to restaurants_path
  end
end
