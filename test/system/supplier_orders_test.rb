require "application_system_test_case"

class SupplierOrdersTest < ApplicationSystemTestCase
  setup do
    @supplier_order = supplier_orders(:one)
  end

  test "visiting the index" do
    visit supplier_orders_url
    assert_selector "h1", text: "Supplier orders"
  end

  test "should create supplier order" do
    visit supplier_orders_url
    click_on "New supplier order"

    fill_in "Bill of material", with: @supplier_order.bill_of_material_id
    fill_in "Date", with: @supplier_order.date
    fill_in "Machine", with: @supplier_order.machine
    fill_in "Number", with: @supplier_order.number
    fill_in "Supplier", with: @supplier_order.supplier_id
    click_on "Create Supplier order"

    assert_text "Supplier order was successfully created"
    click_on "Back"
  end

  test "should update Supplier order" do
    visit supplier_order_url(@supplier_order)
    click_on "Edit this supplier order", match: :first

    fill_in "Bill of material", with: @supplier_order.bill_of_material_id
    fill_in "Date", with: @supplier_order.date
    fill_in "Machine", with: @supplier_order.machine
    fill_in "Number", with: @supplier_order.number
    fill_in "Supplier", with: @supplier_order.supplier_id
    click_on "Update Supplier order"

    assert_text "Supplier order was successfully updated"
    click_on "Back"
  end

  test "should destroy Supplier order" do
    visit supplier_order_url(@supplier_order)
    click_on "Destroy this supplier order", match: :first

    assert_text "Supplier order was successfully destroyed"
  end
end
