require "test_helper"

class BillOfMaterialLinesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @bill_of_material_line = bill_of_material_lines(:one)
  end

  test "should get index" do
    get bill_of_material_lines_url
    assert_response :success
  end

  test "should get new" do
    get new_bill_of_material_line_url
    assert_response :success
  end

  test "should create bill_of_material_line" do
    assert_difference("BillOfMaterialLine.count") do
      post bill_of_material_lines_url, params: { bill_of_material_line: { bill_of_material_id: @bill_of_material_line.bill_of_material_id, code: @bill_of_material_line.code, name: @bill_of_material_line.name, quantity: @bill_of_material_line.quantity } }
    end

    assert_redirected_to bill_of_material_line_url(BillOfMaterialLine.last)
  end

  test "should show bill_of_material_line" do
    get bill_of_material_line_url(@bill_of_material_line)
    assert_response :success
  end

  test "should get edit" do
    get edit_bill_of_material_line_url(@bill_of_material_line)
    assert_response :success
  end

  test "should update bill_of_material_line" do
    patch bill_of_material_line_url(@bill_of_material_line), params: { bill_of_material_line: { bill_of_material_id: @bill_of_material_line.bill_of_material_id, code: @bill_of_material_line.code, name: @bill_of_material_line.name, quantity: @bill_of_material_line.quantity } }
    assert_redirected_to bill_of_material_line_url(@bill_of_material_line)
  end

  test "should destroy bill_of_material_line" do
    assert_difference("BillOfMaterialLine.count", -1) do
      delete bill_of_material_line_url(@bill_of_material_line)
    end

    assert_redirected_to bill_of_material_lines_url
  end
end
