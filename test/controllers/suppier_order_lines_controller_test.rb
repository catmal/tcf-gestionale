require 'test_helper'

class SuppierOrderLinesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @supplier_order_line = supplier_order_lines(:one)
  end

  test 'should get index' do
    get supplier_order_lines_url
    assert_response :success
  end

  test 'should get new' do
    get new_supplier_order_line_url
    assert_response :success
  end

  test 'should create supplier_order_line' do
    assert_difference('SuppierOrderLine.count') do
      post supplier_order_lines_url,
           params: { supplier_order_line: { component_id: @supplier_order_line.component_id,
                                            quantity_id: @supplier_order_line.quantity_id, supplier_order_id: @supplier_order_line.supplier_order_id } }
    end

    assert_redirected_to supplier_order_line_url(SuppierOrderLine.last)
  end

  test 'should show supplier_order_line' do
    get supplier_order_line_url(@supplier_order_line)
    assert_response :success
  end

  test 'should get edit' do
    get edit_supplier_order_line_url(@supplier_order_line)
    assert_response :success
  end

  test 'should update supplier_order_line' do
    patch supplier_order_line_url(@supplier_order_line),
          params: { supplier_order_line: { component_id: @supplier_order_line.component_id,
                                           quantity_id: @supplier_order_line.quantity_id, supplier_order_id: @supplier_order_line.supplier_order_id } }
    assert_redirected_to supplier_order_line_url(@supplier_order_line)
  end

  test 'should destroy supplier_order_line' do
    assert_difference('SuppierOrderLine.count', -1) do
      delete supplier_order_line_url(@supplier_order_line)
    end

    assert_redirected_to supplier_order_lines_url
  end
end
