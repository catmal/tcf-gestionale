class Menu < ApplicationRecord
  ITEMS = [
    { name: 'Distinte', icon: 'fa-brands fa-wpexplorer', link: '/bill_of_materials',
      controller: 'movies' },
    { name: 'Articoli', icon: 'fa-solid fa-ranking-star', link: '/items', controller: 'movie_ranks' }

  ].freeze
end
