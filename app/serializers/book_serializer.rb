class BookSerializer < ActiveModel::Serializer
  attributes :id, :ISBN_13, :title, :image, :author, :price, :publisher, :rank, :description, :categories
end



