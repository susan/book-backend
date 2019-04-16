class CreateBooks < ActiveRecord::Migration[5.2]
  def change
    create_table :books do |t|
      t.string :title
      t.string :ISBN_13
      t.string :image
      t.string :author
      t.float :price
      t.string :publisher
      t.integer :rank
      t.text :description
      t.string :categories




      t.timestamps
    end
  end
end
