require "test_helper"

class NbaControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get nba_index_url
    assert_response :success
  end
end
