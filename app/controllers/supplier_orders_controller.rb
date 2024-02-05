class SupplierOrdersController < ApplicationController
  before_action :set_supplier_order, only: %i[show edit update destroy send_email add_component_to_supplier_order]

  # GET /supplier_orders
  def index
    @supplier_orders = SupplierOrder.includes([:supplier])
  end

  # GET /supplier_orders/1
  def show; end

  # GET /supplier_orders/new
  def new
    @suppliers = Supplier.all
    @bill_of_material = BillOfMaterial.find(params[:bill_of_material_id])
    @bill_of_material_lines = @bill_of_material.bill_of_material_lines.order(component_id: :asc)
    @supplier_order = @bill_of_material.supplier_orders.create(bill_of_material_id: @bill_of_material.id,
                                                               date: Date.today)
    @component_buttons = @bill_of_material.purchase_orders.first.order_lines
  end

  def new_supplier_order_from_bill_of_material
    @suppliers = Supplier.all
    @bill_of_material = BillOfMaterial.find(params[:bill_of_material_id])
    @bill_of_material_lines = @bill_of_material.bill_of_material_lines
    session_initializer = SupplierOrders::Builder.new(@bill_of_material)
    session_initializer.initialize_session_variables(session)
    @supplier_order = SupplierOrder.new(bill_of_material_id: @bill_of_material.id, date: Date.today)
  end

  def add_component_to_supplier_order
    @component_buttons = @bill_of_material.purchase_orders.first.order_lines

    @bill_of_material_line = BillOfMaterialLine.find(params[:line])
    @bill_of_material = @bill_of_material_line.bill_of_material
    @bill_of_material_lines = @bill_of_material.bill_of_material_lines.order(component_id: :asc)
    @supplier_order_line = @supplier_order.supplier_order_lines.find_by(item_id: @bill_of_material_line.component.id)
    @updated = false
    if @supplier_order_line.present?
      @updated = true
      if @bill_of_material_line.quantity > @supplier_order_line.quantity
        @supplier_order_line.quantity = @supplier_order_line.quantity + 1
      end
      @supplier_order_line.save
    else
      @supplier_order_line = @supplier_order.supplier_order_lines.create(item_id: @bill_of_material_line.component.id,
                                                                         quantity: 1)

    end
    if @bill_of_material_line.quantity > @bill_of_material_line.ordered
      @bill_of_material_line.ordered = @bill_of_material_line.ordered + 1
    end
    @bill_of_material_line.to_order = @bill_of_material_line.to_order - 1 if @bill_of_material_line.to_order.positive?
    @bill_of_material_line.save
    @supplier_order_line
  end

  # GET /supplier_orders/1/edit
  def edit
    @bill_of_material = @supplier_order.bill_of_material
    @component_buttons = @bill_of_material.purchase_orders.first.order_lines
  end

  # POST /supplier_orders
  def create
    @supplier_order = SupplierOrder.new(supplier_order_params)

    if @supplier_order.save!
      # session["supplier_order_#{@supplier_order.bill_of_material_id}_supplier_order_lines"].each do |line|
      #   @supplier_order.supplier_order_lines.create!(item_id: line[:item_id], quantity: line[:quantity])
      # end
      # session["supplier_order_#{@supplier_order.bill_of_material_id}_supplier_order_lines"] = []
      # session["bill_of_material_#{@supplier_order.bill_of_material_id}_bill_of_material_lines"] = []

      redirect_to edit_supplier_order_path(@supplier_order)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def send_email
    SupplierOrderMailer.with(supplier_order: @supplier_order).new_supplier_order_email.deliver_later
    redirect_to @supplier_order, notice: 'Email inviata al fornitore con successo!'
  end

  # PATCH/PUT /supplier_orders/1
  def update
    if @supplier_order.update(supplier_order_params)
      redirect_to @supplier_order, notice: 'Supplier order was successfully updated.', status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /supplier_orders/1
  def destroy
    @supplier_order.destroy!
    redirect_to supplier_orders_url, notice: 'Ordine fornitore distrutto con successo!', status: :see_other
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_supplier_order
    @supplier_order = SupplierOrder.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def supplier_order_params
    params.require(:supplier_order).permit(:number, :supplier_id, :date, :bill_of_material_id, :machine)
  end
end
