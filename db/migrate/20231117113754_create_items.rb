class CreateItems < ActiveRecord::Migration[7.1]
  def change
    create_table :items do |t|
      t.string :name
      t.string :code
      t.string :type
      t.string :pdf_url
      t.string :dxf_url

      t.timestamps
    end
  end
end
