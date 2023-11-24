class BillOfMaterialsController < ApplicationController
  before_action :set_bill_of_material, only: %i[show edit update destroy]
  require 'roo'

  # GET /bill_of_materials or /bill_of_materials.json
  def index
    @bill_of_materials = BillOfMaterial.all
  end

  def components
    bill_of_material = BillOfMaterial.find(params[:bill_of_material])
    respond_to do |format|
      format.html
      format.csv do
        send_data bill_of_material.components_to_csv,
                  filename: "componenti-#{DateTime.now.strftime('%d%m%Y%H%M')}.csv"
      end
    end
  end

  def groups
    bill_of_material = BillOfMaterial.find(params[:bill_of_material])
    @group = Group.find_by(code: params[:group])
    @group = @group.children
    respond_to do |format|
      format.html
      format.csv do
        send_data bill_of_material.groups_to_csv,
                  filename: "gruppo-#{params[:group]}.csv", notice: "Il gruppo e' stato esportato con successo"
      end
    end
  end

  # GET /bill_of_materials/1 or /bill_of_materials/1.json
  def show; end

  # GET /bill_of_materials/new
  def import
    file = params[:xml_file]
    xlsx = Roo::Spreadsheet.open(file, extension: :xlsx)
    count = xlsx.count
    session[:bill_of_material_lines] = []
    session[:group] = {}
    session[:components] = []
    session[:groups] = []

    for i in 2...count do
      group_code = xlsx.row(i)[0]
      code = xlsx.row(i)[1]
      name = xlsx.row(i)[2]
      component_quantity =  (xlsx.row(i)[3] * 1000).to_i if xlsx.row(i)[3].present?

      bill_of_material_line = { code:, name:, component_quantity:, group_code:, type: 'Component' }
      group = { code: group_code, type: 'Group' }
      session[:groups].push(group) if group_code.present? && !session[:groups].include?(group)
      session[:bill_of_material_lines].push(bill_of_material_line) if code.present?
    end
    respond_to do |format|
      if session[:bill_of_material_lines]
        format.html do
          redirect_to new_bill_of_material_url, notice: 'Bill of material was successfully created.'
        end

      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @bill_of_material.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /bill_of_materials/1/edit
  def edit; end

  def new
    @bill_of_material_lines = session[:bill_of_material_lines]
    @bill_of_material = session[:bill_of_material]
  end

  # POST /bill_of_materials or /bill_of_materials.json
  def create
    @bill_of_material = BillOfMaterial.new(date: Date.today,
                                           number: BillOfMaterial.last ? BillOfMaterial.last.number.to_i + 1 : 1)

    respond_to do |format|
      if @bill_of_material.save
        session[:groups].each do |group|
          Items::ItemPersister.new(group).save
        end
        @bill_of_material_lines = session[:bill_of_material_lines].each do |line|
          item = Items::ItemPersister.new(line).save
          group = Group.find_by(code: line[:group_code])
          @bill_of_material.bill_of_material_lines.create!(quantity: line[:component_quantity], component_id: item.id, group_id: group.id,
                                                           bill_of_material: @bill_of_material, group:)
        end
        format.html do
          redirect_to bill_of_material_url(@bill_of_material), notice: 'Bill of material was successfully created.'
        end
        format.json { render :show, status: :created, location: @bill_of_material }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @bill_of_material.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bill_of_materials/1 or /bill_of_materials/1.json
  def update
    respond_to do |format|
      if @bill_of_material.update(bill_of_material_params)
        format.html do
          redirect_to bill_of_material_url(@bill_of_material), notice: 'Bill of material was successfully updated.'
        end
        format.json { render :show, status: :ok, location: @bill_of_material }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @bill_of_material.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bill_of_materials/1 or /bill_of_materials/1.json
  def destroy
    @bill_of_material.destroy!

    respond_to do |format|
      format.html { redirect_to bill_of_materials_url, notice: 'Bill of material was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_bill_of_material
    @bill_of_material = BillOfMaterial.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def bill_of_material_params
    params.require(:bill_of_material).permit(:date, :code)
  end
end
