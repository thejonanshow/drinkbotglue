require "application_system_test_case"

class MotorsTest < ApplicationSystemTestCase
  setup do
    @motor = motors(:one)
  end

  test "visiting the index" do
    visit motors_url
    assert_selector "h1", text: "Motors"
  end

  test "creating a Motor" do
    visit motors_url
    click_on "New Motor"

    check "Online" if @motor.online
    fill_in "Uuid", with: @motor.uuid
    click_on "Create Motor"

    assert_text "Motor was successfully created"
    click_on "Back"
  end

  test "updating a Motor" do
    visit motors_url
    click_on "Edit", match: :first

    check "Online" if @motor.online
    fill_in "Uuid", with: @motor.uuid
    click_on "Update Motor"

    assert_text "Motor was successfully updated"
    click_on "Back"
  end

  test "destroying a Motor" do
    visit motors_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Motor was successfully destroyed"
  end
end
