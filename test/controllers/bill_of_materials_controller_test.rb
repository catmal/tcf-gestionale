require "test_helper"

class BillOfMaterialsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @bill_of_material = bill_of_materials(:one)
  end

  test "should get index" do
    get bill_of_materials_url
    assert_response :success
  end

  test "should get new" do
    get new_bill_of_material_url
    assert_response :success
  end

  test "should create bill_of_material" do
    assert_difference("BillOfMaterial.count") do
      post bill_of_materials_url, params: { bill_of_material: { code: @bill_of_material.code, date: @bill_of_material.date } }
    end

    assert_redirected_to bill_of_material_url(BillOfMaterial.last)
  end

  test "should show bill_of_material" do
    get bill_of_material_url(@bill_of_material)
    assert_response :success
  end

  test "should get edit" do
    get edit_bill_of_material_url(@bill_of_material)
    assert_response :success
  end

  test "should update bill_of_material" do
    patch bill_of_material_url(@bill_of_material), params: { bill_of_material: { code: @bill_of_material.code, date: @bill_of_material.date } }
    assert_redirected_to bill_of_material_url(@bill_of_material)
  end

  test "should destroy bill_of_material" do
    assert_difference("BillOfMaterial.count", -1) do
      delete bill_of_material_url(@bill_of_material)
    end

    assert_redirected_to bill_of_materials_url
  end
end
