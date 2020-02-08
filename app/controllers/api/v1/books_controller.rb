class Api::V1::BooksController < ApplicationController
  before_action :curr_user, only: [:create]

  def index
    @books = Book.all
    render json: @books, status: :ok
  end


  def create
  	if curr_user && @book = Book.find_by(title: params[:book][:title])
      if !@book
        @book = Book.create(book_params)
      end
      @line_item = curr_user.cart.line_items.find_by(book_id: @book.id)
      if @line_item
        @line_item.quantity+=1
      else
       @line_item = create_line_item(@book, curr_user)
      end 
      if @line_item.save
        render json: {book: @book, line_item: @line_item }, status: :created
      else
     	  render json: { errors: @line_item.errors.full_messages }, status: :unprocessible_entity
      end
    end 
  end

   def create_line_item(book, user)
    @cart = Cart.find_by(user_id: user.id)
    line_item = LineItem.create(book_id: book.id, cart_id: @cart.id, quantity:1)
   end

private
  def book_params
  	 params.require(:book).permit(:id, :title, :ISBN_13, :image, :author,
  	  :price, :publisher, :rank, :description, :categories)
  end

end


