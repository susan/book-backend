class Api::V1::BooksController < ApplicationController
  before_action :curr_user, only: [:create]

  def create
  	if curr_user
      @book = Book.find_by(params[:id])
        if !@book
         @book = Book.create(book_params)
        end
      create_line_item(@book, curr_user)
      if @line_item.save
        render json: @line_item, status: :created
      else
     	  render json: { errors: @line_item.errors.full_messages }, status: :unprocessible_entity
      end
   end
  end

   def create_line_item(book, user)
    @cart = Cart.find_by(:user_id => user.id)
    @line_item = LineItem.create(book_id: book.id, cart_id: @cart.id)
   end

private
  def book_params
  	 params.require(:book).permit(:id, :title, :ISBN_13, :image, :author,
  	  :price, :publisher, :rank, :description, :categories)
  end

end


