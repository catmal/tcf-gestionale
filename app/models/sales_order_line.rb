class SalesOrderLine < OrderLine
  after_create :update_to_order

  # Validation to ensure that 'ordered' is a non-negative integer

  private

  def update_to_order
    update(to_order: quantity)
  end
end
