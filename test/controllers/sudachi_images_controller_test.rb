require 'test_helper'

class SudachiImagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @sudachi_image = sudachi_images(:one)
  end

  test "should get index" do
    get sudachi_images_url
    assert_response :success
  end

  test "should get new" do
    get new_sudachi_image_url
    assert_response :success
  end

  test "should create sudachi_image" do
    assert_difference('SudachiImage.count') do
      post sudachi_images_url, params: { sudachi_image: { image: @sudachi_image.image } }
    end

    assert_redirected_to sudachi_image_url(SudachiImage.last)
  end

  test "should show sudachi_image" do
    get sudachi_image_url(@sudachi_image)
    assert_response :success
  end

  test "should get edit" do
    get edit_sudachi_image_url(@sudachi_image)
    assert_response :success
  end

  test "should update sudachi_image" do
    patch sudachi_image_url(@sudachi_image), params: { sudachi_image: { image: @sudachi_image.image } }
    assert_redirected_to sudachi_image_url(@sudachi_image)
  end

  test "should destroy sudachi_image" do
    assert_difference('SudachiImage.count', -1) do
      delete sudachi_image_url(@sudachi_image)
    end

    assert_redirected_to sudachi_images_url
  end
end
