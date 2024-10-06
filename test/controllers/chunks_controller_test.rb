require "test_helper"

class ChunksControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get chunks_index_url
    assert_response :success
  end

  test "should get search" do
    get chunks_search_url
    assert_response :success
  end
end
