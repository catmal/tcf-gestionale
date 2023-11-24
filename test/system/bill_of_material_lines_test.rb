require "application_system_test_case"

class BillOfMaterialLinesTest < ApplicationSystemTestCase
  setup do
    @bill_of_material_line = bill_of_material_lines(:one)
  end

  test "visiting the index" do
    visit bill_of_material_lines_url
    assert_selector "h1", text: "Bill of material lines"
  end

  test "should create bill of material line" do
    visit bill_of_material_lines_url
    click_on "New bill of material line"

    fill_in "Bill of material", with: @bill_of_material_line.bill_of_material_id
    fill_in "Code", with: @bill_of_material_line.code
    fill_in "Name", with: @bill_of_material_line.name
    fill_in "Quantity", with: @bill_of_material_line.quantity
    click_on "Create Bill of material line"

    assert_text "Bill of material line was successfully created"
    click_on "Back"
  end

  test "should update Bill of material line" do
    visit bill_of_material_line_url(@bill_of_material_line)
    click_on "Edit this bill of material line", match: :first

    fill_in "Bill of material", with: @bill_of_material_line.bill_of_material_id
    fill_in "Code", with: @bill_of_material_line.code
    fill_in "Name", with: @bill_of_material_line.name
    fill_in "Quantity", with: @bill_of_material_line.quantity
    click_on "Update Bill of material line"

    assert_text "Bill of material line was successfully updated"
    click_on "Back"
  end

  test "should destroy Bill of material line" do
    visit bill_of_material_line_url(@bill_of_material_line)
    click_on "Destroy this bill of material line", match: :first

    assert_text "Bill of material line was successfully destroyed"
  end
end
