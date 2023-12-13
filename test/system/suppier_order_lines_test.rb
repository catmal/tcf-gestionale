require 'application_system_test_case'

class SuppierOrderLinesTest < ApplicationSystemTestCase
  setup do
    @supplier_order_line = supplier_order_lines(:one)
  end

  test 'visiting the index' do
    visit supplier_order_lines_url
    assert_selector 'h1', text: 'Suppier order lines'
  end

  test 'should create supplier order line' do
    visit supplier_order_lines_url
    click_on 'New supplier order line'

    fill_in 'Component', with: @supplier_order_line.component_id
    fill_in 'Quantity', with: @supplier_order_line.quantity_id
    fill_in 'Supplier order', with: @supplier_order_line.supplier_order_id
    click_on 'Create Suppier order line'

    assert_text 'Suppier order line was successfully created'
    click_on 'Back'
  end

  test 'should update Suppier order line' do
    visit supplier_order_line_url(@supplier_order_line)
    click_on 'Edit this supplier order line', match: :first

    fill_in 'Component', with: @supplier_order_line.component_id
    fill_in 'Quantity', with: @supplier_order_line.quantity_id
    fill_in 'Supplier order', with: @supplier_order_line.supplier_order_id
    click_on 'Update Suppier order line'

    assert_text 'Suppier order line was successfully updated'
    click_on 'Back'
  end

  test 'should destroy Suppier order line' do
    visit supplier_order_line_url(@supplier_order_line)
    click_on 'Destroy this supplier order line', match: :first

    assert_text 'Suppier order line was successfully destroyed'
  end
end
