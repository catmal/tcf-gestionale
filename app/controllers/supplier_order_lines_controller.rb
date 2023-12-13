class SupplierOrderLinesController < ApplicationController
  before_action :set_supplier_order_line, only: %i[show edit update destroy]

  # GET /supplier_order_lines
  def index
    @supplier_order_lines = SuppierOrderLine.all
  end

  # GET /supplier_order_lines/1
  def show; end

  # GET /supplier_order_lines/new
  def new
    @supplier_order_line = SuppierOrderLine.new
  end

  # GET /supplier_order_lines/1/edit
  def edit; end

  # POST /supplier_order_lines
  def create
    @supplier_order_line = SuppierOrderLine.new(supplier_order_line_params)

    if @supplier_order_line.save
      redirect_to @supplier_order_line, notice: 'Suppier order line was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /supplier_order_lines/1
  def update
    if @supplier_order_line.update(supplier_order_line_params)
      redirect_to @supplier_order_line, notice: 'Suppier order line was successfully updated.', status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /supplier_order_lines/1
  def destroy
    @supplier_order_line.destroy!
    redirect_to supplier_order_lines_url, notice: 'Suppier order line was successfully destroyed.', status: :see_other
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_supplier_order_line
    @supplier_order_line = SuppierOrderLine.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def supplier_order_line_params
    params.require(:supplier_order_line).permit(:supplier_order_id, :component_id, :quantity_id)
  end
end
