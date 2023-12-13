class Item < ApplicationRecord
  require 'csv'

  ## 1. ASSOCIATIONS / ATTRIBUTES

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

  ## 2. SCOPES

  scope :groups, -> { where(type: 'Group') }

  ## 3. CLASS METHODS

  def self.to_csv
    items = all
    CSV.generate do |csv|
      csv << column_names
      items.each do |item|
        csv << [item.code, item.name]
      end
    end
  end

  ## 4. VALIDATES

  validates :code, presence: true, uniqueness: true

  ## 6. INSTANCE METHODS

  def existing?(code)
    Item.find_by(code:)
  end
end
