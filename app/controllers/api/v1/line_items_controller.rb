class Api::V1::LineItemsController < ApplicationController
   before_action :curr_user, only: [:create, :destroy]

  def destroy
    @line_item = LineItem.find(params[:id])

    @line_items = LineItem.all
     if @line_item.cart.user === curr_user
        @line_item.destroy
        render json: @line_item, status: :ok
     else
      render json: { errors: @line_item.errors.full_messages }, status: :unprocessible_entity
     end
  end

	private
  def line_item_params
  	 params.require(:line_item).permit(:id, :quantity, :book_id, :cart_id)
  end

end


#   def create
#   	if curr_user
#      @line_item = LineItem.new(line_item_params)
#      @line_item.user= curr_user
#   end

#   def add_book(book)
#   	@book =Book.create(book)
# #take out user_id so would have to get it from front end

#

# def destroy(item)
# 	@line_item = LineItem.all.find do |element|
# 	  element.book_id === item.book_id &&
# 	  element.cart_id === item.user_id
# 	end
# 	@line_item.destroy
# 	if @line_item.destroy
#     render json: @line_item, status: :deleted
#   else
#      render json: { errors: @line_item.errors.full_messages }, status: :unprocessible_entity
#   end)
# end





