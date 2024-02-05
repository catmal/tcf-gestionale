class Menu < ApplicationRecord
  ITEMS = [
    { name: 'Distinte', icon: 'fa-brands fa-dochub', link: '/bill_of_materials',
      controller: 'bill_of_materials' },
    { name: 'Articoli', icon: 'fa-solid fa-gear', link: '/items', controller: 'items' },
    { name: 'Fornitori', icon: 'fa-solid fa-users', link: '/suppliers', controller: 'suppliers' },
    { name: 'Ordini Clienti', icon: 'fa-solid fa-truck', link: '/sales_orders',
      controller: 'sales_orders' },
    { name: 'Ordini Fornitori', icon: 'fa-solid fa-truck', link: '/purchase_orders',
      controller: 'purchase_orders' }

  ].freeze
end
