class OrderLinesController < ApplicationController
  before_action :set_order_line, only: %i[ show edit update destroy ]

  # GET /order_lines
  def index
    @order_lines = OrderLine.all
  end

  # GET /order_lines/1
  def show
  end

  # GET /order_lines/new
  def new
    @order_line = OrderLine.new
  end

  # GET /order_lines/1/edit
  def edit
  end

  # POST /order_lines
  def create
    @order_line = OrderLine.new(order_line_params)

    if @order_line.save
      redirect_to @order_line, notice: "Order line was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /order_lines/1
  def update
    if @order_line.update(order_line_params)
      redirect_to @order_line, notice: "Order line was successfully updated.", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /order_lines/1
  def destroy
    @order_line.destroy!
    redirect_to order_lines_url, notice: "Order line was successfully destroyed.", status: :see_other
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order_line
      @order_line = OrderLine.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def order_line_params
      params.require(:order_line).permit(:order_id, :item_id, :quantity)
    end
end
