require "test_helper"

class SupplierOrdersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @supplier_order = supplier_orders(:one)
  end

  test "should get index" do
    get supplier_orders_url
    assert_response :success
  end

  test "should get new" do
    get new_supplier_order_url
    assert_response :success
  end

  test "should create supplier_order" do
    assert_difference("SupplierOrder.count") do
      post supplier_orders_url, params: { supplier_order: { bill_of_material_id: @supplier_order.bill_of_material_id, date: @supplier_order.date, machine: @supplier_order.machine, number: @supplier_order.number, supplier_id: @supplier_order.supplier_id } }
    end

    assert_redirected_to supplier_order_url(SupplierOrder.last)
  end

  test "should show supplier_order" do
    get supplier_order_url(@supplier_order)
    assert_response :success
  end

  test "should get edit" do
    get edit_supplier_order_url(@supplier_order)
    assert_response :success
  end

  test "should update supplier_order" do
    patch supplier_order_url(@supplier_order), params: { supplier_order: { bill_of_material_id: @supplier_order.bill_of_material_id, date: @supplier_order.date, machine: @supplier_order.machine, number: @supplier_order.number, supplier_id: @supplier_order.supplier_id } }
    assert_redirected_to supplier_order_url(@supplier_order)
  end

  test "should destroy supplier_order" do
    assert_difference("SupplierOrder.count", -1) do
      delete supplier_order_url(@supplier_order)
    end

    assert_redirected_to supplier_orders_url
  end
end
