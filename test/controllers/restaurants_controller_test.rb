require 'test_helper'

class RestaurantsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

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
    sign_in users(:one)
    get new_restaurant_url
    assert_select 'h1', 'New Restaurant'
    assert_response :success
  end

  test "should create restaurant" do
    sign_in users(:one)
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
    sign_in users(:one)
    get edit_restaurant_url(@restaurant)
    assert_response :success
  end

  test "should update restaurant" do
    sign_in users(:one)
    patch restaurant_url(@restaurant), params: { restaurant: { downvotes: @restaurant.downvotes, location: @restaurant.location, name: @restaurant.name, upvotes: @restaurant.upvotes } }
    assert_redirected_to restaurants_path
  end

  test "should show upvotes" do
    sign_in users(:one)
    assert_equal(@restaurant.upvotes, 10)
  end

  test "should show downvotes" do
    sign_in users(:one)
    assert_equal(@restaurant.downvotes, 1)
  end

  test "should add an upvote" do
    sign_in users(:one)
    assert_equal(@restaurant.upvotes, 10)
    get upvote_path(:restaurant_id => @restaurant.id)
    @restaurant.reload
    assert_redirected_to restaurants_url
    follow_redirect!
    assert_response 200
    assert_select 'aside', "Vote successfully cast."
    assert_equal(@restaurant.upvotes, 11)
  end

  test "should add a downvote" do
    sign_in users(:two)
    assert_equal(@restaurant2.downvotes, 5)
    get downvote_path(:restaurant_id => @restaurant2.id)
    @restaurant2.reload
    assert_redirected_to restaurants_url
    follow_redirect!
    assert_response 200
    assert_select 'aside', "Vote successfully cast."
    assert_equal(@restaurant2.downvotes, 6)
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
