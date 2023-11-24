# frozen_string_literal: true

module Items
  class ItemPersister
    def initialize(item)
      @item = item
    end

    def save
      item = Item.find_by(code: @item[:code])

      if item.present? && @item[:type] == 'Component'
        group = Group.find_by(code: @item[:group_code])
        group = Group.create(code: @item[:group_code]) if group.blank?

        group.children << item unless group.children.include?(item)
      elsif item.blank? && @item[:type] == 'Component'
        item = Component.create(code: @item[:code],
                                name: @item[:name])
        group = Group.find_by(code: @item[:group_code])
        group = Group.create(code: @item[:group_code]) if group.blank?
        group.children << item unless group.children.include?(item)
      elsif @item[:type] == 'Group'
        group = Group.find_by(code: @item[:group_code])
        item = Group.create(code: @item[:group_code]) if group.nil?
      end
      item
    end
  end
end
