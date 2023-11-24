class CreateItemConnections < ActiveRecord::Migration[7.1]
  def change
    create_table :item_connections, id: false do |t|
      t.integer :parent_id
      t.integer :child_id
    end

    add_foreign_key :item_connections, :items, column: :parent_id
    add_foreign_key :item_connections, :items, column: :child_id
  end
end
