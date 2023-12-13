class SupplierOrdersController < ApplicationController
  before_action :set_supplier_order, only: %i[show edit update destroy send_email]

  # GET /supplier_orders
  def index
    @supplier_orders = SupplierOrder.all
  end

  # GET /supplier_orders/1
  def show; end

  # GET /supplier_orders/new
  def new
    @suppliers = Supplier.all
    @bill_of_material = BillOfMaterial.find(params[:bill_of_material])
    @bill_of_material_lines = @bill_of_material.bill_of_material_lines
    session["bill_of_material_#{@bill_of_material.id}_bill_of_material_lines"] = @bill_of_material_lines
    @supplier_order = SupplierOrder.new(bill_of_material_id: @bill_of_material.id, date: Date.today)
  end

  def add_component_to_supplier_order
    @bill_of_material_line = BillOfMaterialLine.find(params[:line])
    @bill_of_material = @bill_of_material_line.bill_of_material

    @existing = session["supplier_order_#{@bill_of_material.id}_supplier_order_lines"].find do |line|
      line[:code] == @bill_of_material_line.component.code
    end
    if @existing.present?
      @existing[:quantity] = @existing[:quantity].to_i + 1 if @existing[:quantity] < @bill_of_material_line.quantity
    else
      session["supplier_order_#{@bill_of_material.id}_supplier_order_lines"].push(
        {
          item_id: @bill_of_material_line.component.id,
          quantity: 1,
          name: @bill_of_material_line.component.name,
          code: @bill_of_material_line.component.code
        }
      )
    end

    button = session["bill_of_material_#{@bill_of_material.id}_bill_of_material_lines"].find do |line|
      line.component.code == @bill_of_material_line.component.code
    end

    button[:quantity] = button[:quantity] - 1 if button.present? && button[:quantity].to_i.positive?
    respond_to do |format|
      format.html do
        render partial: 'supplier_order_lines',
               locals: { supplier_order_lines: session["supplier_order_#{@bill_of_material.id}_supplier_order_lines"] }
      end
      format.turbo_stream do
        flash[:notice] =
          "Componente #{@bill_of_material_line.component.code} #{@bill_of_material_line.component.name} aggiunto all'ordine!"
      end
    end
  end

  # GET /supplier_orders/1/edit
  def edit; end

  # POST /supplier_orders
  def create
    @supplier_order = SupplierOrder.new(supplier_order_params)
    @supplier_order.bill_of_material_id = session[:bill_of_material_lines].first[:bill_of_material_id]

    if @supplier_order.save
      session[:supplier_order_lines].each do |line|
        line = @supplier_order.supplier_order_lines.create!(item_id: line[:item_id], quantity: line[:quantity])
      end
      session[:supplier_order_lines] = []
      redirect_to @supplier_order, notice: 'Supplier order was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def send_email
    SupplierOrderMailer.with(supplier_order: @supplier_order).new_supplier_order_email.deliver_later
    redirect_to @supplier_order, notice: 'Supplier order was successfully created.'
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
    redirect_to supplier_orders_url, notice: 'Supplier order was successfully destroyed.', status: :see_other
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
