class Menu < ApplicationRecord
  ITEMS = [
    { name: 'Distinte', icon: 'fa-brands fa-wpexplorer', link: '/bill_of_materials',
      controller: 'bill_of_materials' },
    { name: 'Articoli', icon: 'fa-solid fa-ranking-star', link: '/items', controller: 'items' },
    { name: 'Fornitori', icon: 'fa-solid fa-ranking-star', link: '/suppliers', controller: 'suppliers' },
    { name: 'Ordini Fornitori', icon: 'fa-solid fa-ranking-star', link: '/supplier_orders',
      controller: 'supplier_orders' }

  ].freeze
end
