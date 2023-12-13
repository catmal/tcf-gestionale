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
    @group_components = @group.children
    bill_of_material_lines = bill_of_material.bill_of_material_lines
    respond_to do |format|
      format.html
      format.csv do
        send_data @group.group_to_csv(bill_of_material_lines),
                  filename: "gruppo-#{params[:group]}.csv", notice: "Il gruppo e' stato esportato con successo"
      end
    end
  end

  def purchase_order_groups
    bill_of_material = BillOfMaterial.find(params[:bill_of_material])
    respond_to do |format|
      format.html
      format.csv do
        send_data bill_of_material.purchase_order_groups_to_csv,
                  filename: "gruppi-ordine-acquisto-#{bill_of_material.id}.csv", notice: "Il gruppo e' stato esportato con successo"
      end
    end
  end

  # GET /bill_of_materials/1 or /bill_of_materials/1.json
  def show
    @supplier_orders = @bill_of_material.supplier_orders
  end

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
      component_quantity = (xlsx.row(i)[3]).to_i if xlsx.row(i)[3].present?
      existing = Item.find_by(code:)&.created_at

      bill_of_material_line = { code:, name:, component_quantity:, group_code:, type: 'Component', existing: }
      group = { code: group_code, type: 'Group' }
      session[:groups].push(group) if group_code.present? && name.present? && !session[:groups].include?(group)
      session[:bill_of_material_lines].push(bill_of_material_line) if name.present?

    end
    respond_to do |format|
      if session[:bill_of_material_lines]
        format.html do
          redirect_to new_bill_of_material_url, notice: 'Distinta importa con successo!'
        end

      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @bill_of_material.errors, status: :unprocessable_entity }
      end
    end
  end

  def import_purchase_order
    @bill_of_material = BillOfMaterial.find(params[:bill_of_material_id])

    PurchaseOrder::GroupsScraper.new(@bill_of_material.purchase_order_url, @bill_of_material.groups.uniq).call
    PurchaseOrder::FileScraper.new(@bill_of_material.purchase_order_url, 'pdf').call
    PurchaseOrder::FileScraper.new(@bill_of_material.purchase_order_url, 'dxf').call
    respond_to do |format|
      format.html do
        redirect_to bill_of_material_path(@bill_of_material), notice: 'Bill of material was successfully created.'
      end
    end
  end

  # GET /bill_of_materials/1/edit
  def edit; end

  def new
    @bill_of_material = session[:bill_of_material]
    @bill_of_material_lines = session[:bill_of_material_lines]
  end

  # POST /bill_of_materials or /bill_of_materials.json
  def create
    @bill_of_material = BillOfMaterial.new(date: Date.today)

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
          redirect_to bill_of_material_url(@bill_of_material), notice: 'Distinta salvata con successo!'
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
          redirect_to bill_of_material_url(@bill_of_material), notice: 'Link salavato con successo!'
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
      format.html { redirect_to bill_of_materials_url, notice: 'Distinta distrutta con successo!' }
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
    params.require(:bill_of_material).permit(:date, :code, :purchase_order_url)
  end
end
