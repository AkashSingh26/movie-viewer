require "test_helper"

class Api::V1::RatingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @api_v1_rating = api_v1_ratings(:one)
  end

  test "should get index" do
    get api_v1_ratings_url, as: :json
    assert_response :success
  end

  test "should create api_v1_rating" do
    assert_difference('Api::V1::Rating.count') do
      post api_v1_ratings_url, params: { api_v1_rating: {  } }, as: :json
    end

    assert_response 201
  end

  test "should show api_v1_rating" do
    get api_v1_rating_url(@api_v1_rating), as: :json
    assert_response :success
  end

  test "should update api_v1_rating" do
    patch api_v1_rating_url(@api_v1_rating), params: { api_v1_rating: {  } }, as: :json
    assert_response 200
  end

  test "should destroy api_v1_rating" do
    assert_difference('Api::V1::Rating.count', -1) do
      delete api_v1_rating_url(@api_v1_rating), as: :json
    end

    assert_response 204
  end
end
