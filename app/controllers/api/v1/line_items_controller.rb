class Api::V1::LineItemsController < ApplicationController
   before_action :curr_user, only: [:update]
   after_action only: [:update] do
     check_quantity(@line_item)
   end

  def update
     @line_item = LineItem.find(params[:id])
     if curr_user && update_line_item(curr_user, @line_item)
       @book = Book.find_by(id: @line_item.book_id)
       render json: {line_item: @line_item, book: @book}, status: :ok
     else
      render json: { errors: @line_item.errors.full_messages }, status: :unprocessable_entity
     end
  end

  def update_line_item(current_user, line_item)
    if line_item.cart.user === current_user
      line_item.quantity -= 1
      line_item.save
    end
  end
  private

  def check_quantity(line_item)
     line_item.destroy if line_item.quantity.zero?
   end

  def line_item_params
  	 params.require(:line_item).permit(:id, :quantity, :book_id, :cart_id)
  end

end





