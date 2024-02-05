class Item < ApplicationRecord
  require 'csv'

  FILTER_PARAMS = %i[query column direction].freeze

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
  scope :by_name, ->(query) { where('items.name ilike ?', "%#{query}%") }
  scope :by_code, ->(query) { where('items.code ilike ?', "%#{query}%") }
  scope :by_name_or_code, lambda { |query|
    by_name(query).or(by_code(query))
  }
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

  def self.filter(filters)
    column = filters['column'] || 'name'
    Item
      .by_name_or_code(filters['query'])
      .order("#{column} #{filters['direction']}")
  end
end
