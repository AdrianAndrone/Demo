require 'test_helper'

class FiledownloadsControllerTest < ActionController::TestCase
  test "should get download" do
    get :download
    assert_response :success
  end

end
