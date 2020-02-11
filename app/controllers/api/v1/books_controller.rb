class Api::V1::BooksController < ApplicationController
  #before_action :curr_user, only: [:create]

  def index
    @books = Book.all
    render json: @books, status: :ok
  end


  def create
    @book = Book.find_by(title: params[:book][:title])
      if !@book
       @book = Book.create(book_params)
      end
    if curr_user 
       @line_item = update_line_item(curr_user, @book)
      if @line_item
        render json: {book: @book, line_item: @line_item }, status: :created
      else
     	  render json: { errors: @line_item.errors.full_messages }, status: :not_acceptable
      end
   end
  end

   def create_line_item(user, book)
     @cart = Cart.find_by(user_id: user.id)
     line_item = LineItem.create(book_id: book.id, cart_id: @cart.id, quantity:1)
   end

   def update_line_item(user, book) 
     line_item = user.cart.line_items.find_by(book_id: book.id)
     if line_item  
       line_item.quantity += 1  
       line_item.save
       line_item 
     else
       line_item = create_line_item(user, book)
     end
     line_item
   end

private

  def book_params
  	 params.require(:book).permit(:id, :title, :ISBN_13, :image, :author,
  	  :price, :publisher, :rank, :description, :categories)
  end

end


