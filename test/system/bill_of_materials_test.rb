require "application_system_test_case"

class BillOfMaterialsTest < ApplicationSystemTestCase
  setup do
    @bill_of_material = bill_of_materials(:one)
  end

  test "visiting the index" do
    visit bill_of_materials_url
    assert_selector "h1", text: "Bill of materials"
  end

  test "should create bill of material" do
    visit bill_of_materials_url
    click_on "New bill of material"

    fill_in "Code", with: @bill_of_material.code
    fill_in "Date", with: @bill_of_material.date
    click_on "Create Bill of material"

    assert_text "Bill of material was successfully created"
    click_on "Back"
  end

  test "should update Bill of material" do
    visit bill_of_material_url(@bill_of_material)
    click_on "Edit this bill of material", match: :first

    fill_in "Code", with: @bill_of_material.code
    fill_in "Date", with: @bill_of_material.date
    click_on "Update Bill of material"

    assert_text "Bill of material was successfully updated"
    click_on "Back"
  end

  test "should destroy Bill of material" do
    visit bill_of_material_url(@bill_of_material)
    click_on "Destroy this bill of material", match: :first

    assert_text "Bill of material was successfully destroyed"
  end
end
