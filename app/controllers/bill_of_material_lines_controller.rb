class BillOfMaterialLinesController < ApplicationController
  before_action :set_bill_of_material_line, only: %i[ show edit update destroy ]

  # GET /bill_of_material_lines
  def index
    @bill_of_material_lines = BillOfMaterialLine.all
  end

  # GET /bill_of_material_lines/1
  def show
  end

  # GET /bill_of_material_lines/new
  def new
    @bill_of_material_line = BillOfMaterialLine.new
  end

  # GET /bill_of_material_lines/1/edit
  def edit
  end

  # POST /bill_of_material_lines
  def create
    @bill_of_material_line = BillOfMaterialLine.new(bill_of_material_line_params)

    if @bill_of_material_line.save
      redirect_to @bill_of_material_line, notice: "Bill of material line was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /bill_of_material_lines/1
  def update
    if @bill_of_material_line.update(bill_of_material_line_params)
      redirect_to @bill_of_material_line, notice: "Bill of material line was successfully updated.", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /bill_of_material_lines/1
  def destroy
    @bill_of_material_line.destroy!
    redirect_to bill_of_material_lines_url, notice: "Bill of material line was successfully destroyed.", status: :see_other
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bill_of_material_line
      @bill_of_material_line = BillOfMaterialLine.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def bill_of_material_line_params
      params.require(:bill_of_material_line).permit(:code, :name, :quantity, :bill_of_material_id)
    end
end
