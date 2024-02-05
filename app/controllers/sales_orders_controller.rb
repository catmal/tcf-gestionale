class SalesOrdersController < OrdersController
  before_action :set_order, only: %i[show edit update destroy]

  # GET /orders
  def index
    @sales_orders = SalesOrder.where(receivable: current_company)
  end

  # GET /orders/1
  def show; end

  # GET /orders/new
  def new
    @order = PurchaseOrder.new(date: Date.today)
    @suppliers = Supplier.all
  end

  # GET /orders/1/edit
  def edit; end

  # POST /orders
  def create
    @order = PurchaseOrder.new(order_params)
    @order.receivable_type = 'Supplier'
    @order.sendable = current_company

    if @order.save
      redirect_to @order, notice: 'Order was successfully created.'
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
    @order = SalesOrder.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def order_params
    params.require(:sales_order).permit(:date, :number, :sendable_id, :receivable_id, :type)
  end
end
