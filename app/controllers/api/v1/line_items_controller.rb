class Api::V1::LineItemsController < ApplicationController
   before_action :curr_user, only: [:update]

  def update
     @line_item = LineItem.find(params[:id])
     if curr_user && update_line_item(curr_user, @line_item)
      @line_items=curr_user.cart.line_items
      @books = curr_user.cart.books
       render json: {line_items: @line_items, books: @books}, status: :ok
     else
      render json: { errors: @line_item.errors.full_messages }, status: :unprocessable_entity
     end
  end

  def update_line_item(current_user, line_item) 
    if line_item.cart.user === current_user 
      if line_item.quantity > 1
         line_item.quantity -= 1
         line_item.save
      else
        line_item.destroy
        line_item
      end
      line_item
    end
end           
  private
  
  def line_item_params
  	 params.require(:line_item).permit(:id, :quantity, :book_id, :cart_id)
  end

end





