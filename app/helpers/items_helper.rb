module ItemsHelper
  def item_type(type)
    return 'C' if type == 'Component'

    'G'
  end

  def build_order_link(column:, label:)
    if column == session.dig('item_filters', 'column')
      link_to(label, items_path(column:, direction: next_direction))
    else
      link_to(label, items_path(column:, direction: 'asc'))
    end
  end

  def next_direction
    session['item_filters']['direction'] == 'asc' ? 'desc' : 'asc'
  end

  def sort_indicator
    icon = session['item_filters']['direction'] == 'desc' ? 'down' : 'up'
    tag.i(class: "fa-solid fa-arrow-#{icon}")
  end
end
