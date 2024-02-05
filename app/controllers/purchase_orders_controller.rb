class PurchaseOrdersController < OrdersController
  before_action :set_order, only: %i[show edit update destroy add_component_to_supplier_order]

  # GET /orders
  def index
    @purchase_orders = PurchaseOrder.where(sendable: current_company)
  end

  # GET /orders/1
  def show
    @current_company = current_company
  end

  # GET /orders/new
  def new
    @sales_order = SalesOrder.find(params[:sales_order_id])
    @order = PurchaseOrder.new(date: Date.today)
    @suppliers = Supplier.all
  end

  # GET /orders/1/edit
  def edit
    @component_buttons = @order.sourceable.order_lines.order(item_id: :asc)
  end

  def add_component_to_supplier_order
    @component_buttons = @order.sourceable.order_lines
    @sales_order_line = @component_buttons.find(params[:line])
    existing = @order.order_lines.find_by(item_id: @sales_order_line.item_id)

    @purchase_order_line = @order.add_component_to_order(@sales_order_line, existing)
    @updated = false
    @updated = true if existing.present?

    @purchase_order_line
  end

  # POST /orders
  def create
    @order = PurchaseOrder.new(order_params)
    @order.receivable_type = 'Supplier'
    @order.sendable = current_company

    if @order.save
      redirect_to edit_purchase_order_path(@order), notice: 'Ordine creato con successo!'
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /orders/1
  def update
    if @order.update(order_params)
      redirect_to @order, notice: 'Order was successfully updated.', status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /orders/1
  def destroy
    @order.destroy!
    redirect_to orders_url, notice: 'Order was successfully destroyed.', status: :see_other
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_order
    @order = Order.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def order_params
    params.require(:purchase_order).permit(:date, :number, :sendable_id, :receivable_id, :type, :sourceable_type,
                                           :sourceable_id)
  end
end
