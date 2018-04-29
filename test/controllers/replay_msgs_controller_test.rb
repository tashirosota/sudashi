require 'test_helper'

class ReplayMsgsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @replay_msg = replay_msgs(:one)
  end

  test "should get index" do
    get replay_msgs_url
    assert_response :success
  end

  test "should get new" do
    get new_replay_msg_url
    assert_response :success
  end

  test "should create replay_msg" do
    assert_difference('ReplayMsg.count') do
      post replay_msgs_url, params: { replay_msg: {  } }
    end

    assert_redirected_to replay_msg_url(ReplayMsg.last)
  end

  test "should show replay_msg" do
    get replay_msg_url(@replay_msg)
    assert_response :success
  end

  test "should get edit" do
    get edit_replay_msg_url(@replay_msg)
    assert_response :success
  end

  test "should update replay_msg" do
    patch replay_msg_url(@replay_msg), params: { replay_msg: {  } }
    assert_redirected_to replay_msg_url(@replay_msg)
  end

  test "should destroy replay_msg" do
    assert_difference('ReplayMsg.count', -1) do
      delete replay_msg_url(@replay_msg)
    end

    assert_redirected_to replay_msgs_url
  end
end
