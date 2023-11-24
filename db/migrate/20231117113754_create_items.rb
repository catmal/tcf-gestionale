class CreateItems < ActiveRecord::Migration[7.1]
  def change
    create_table :items do |t|
      t.string :name
      t.string :code
      t.string :type

      t.timestamps
    end
  end
end
