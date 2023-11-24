class Item < ApplicationRecord
  validates :code, presence: true, uniqueness: true
  require 'csv'
  has_and_belongs_to_many :parents,
                          class_name: 'Item',
                          join_table: 'item_connections',
                          foreign_key: 'child_id',
                          association_foreign_key: 'parent_id'

  has_and_belongs_to_many :children,
                          class_name: 'Item',
                          join_table: 'item_connections',
                          foreign_key: 'parent_id',
                          association_foreign_key: 'child_id'
  scope :groups, -> { where(type: 'Group') }
  def self.to_csv
    items = all
    CSV.generate do |csv|
      csv << column_names
      items.each do |item|
        csv << [item.code, item.name]
      end
    end
  end
end
