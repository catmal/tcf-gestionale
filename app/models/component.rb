class Component < Item
  validates :code, presence: true, uniqueness: true
end
