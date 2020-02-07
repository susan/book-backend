class BookSerializer < ActiveModel::Serializer
  #has_many :line_items
  #has_many :carts, through: :line_items
  attributes :id, :ISBN_13, :title, :image, :author, :price, :publisher, :rank, :description, :categories
end



