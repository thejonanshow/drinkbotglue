require "test_helper"

class BeveragesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @beverage = beverages(:one)
  end

  test "should get index" do
    get beverages_url
    assert_response :success
  end

  test "should get new" do
    get new_beverage_url
    assert_response :success
  end

  test "should create beverage" do
    assert_difference('Beverage.count') do
      post beverages_url, params: { beverage: { amount: @beverage.amount, identifier: @beverage.identifier, image_data: @beverage.image_data, image_url: @beverage.image_url, name: @beverage.name } }
    end

    assert_redirected_to beverage_url(Beverage.last)
  end

  test "should show beverage" do
    get beverage_url(@beverage)
    assert_response :success
  end

  test "should get edit" do
    get edit_beverage_url(@beverage)
    assert_response :success
  end

  test "should update beverage" do
    patch beverage_url(@beverage), params: { beverage: { amount: @beverage.amount, identifier: @beverage.identifier, image_data: @beverage.image_data, image_url: @beverage.image_url, name: @beverage.name } }
    assert_redirected_to beverage_url(@beverage)
  end

  test "should destroy beverage" do
    assert_difference('Beverage.count', -1) do
      delete beverage_url(@beverage)
    end

    assert_redirected_to beverages_url
  end
end
