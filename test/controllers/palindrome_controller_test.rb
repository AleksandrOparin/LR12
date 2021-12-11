require "test_helper"

class PalindromeControllerTest < ActionDispatch::IntegrationTest
  test "should get input" do
    get palindrome_input_url
    assert_response :success
  end

  test "should get output" do
    get palindrome_output_url
    assert_response :success
  end
end
