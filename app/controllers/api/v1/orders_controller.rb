module Api::V1
	class OrdersController < ApplicationController
		def index
			@orders
			render json: @orders
		end

		def create
			new_status = Status.find_by(name: "Waiting for delivery")
			new_order = Order.create(user: @current_user, status: new_status)
			order_params[:items_purchased].each do |order_item|
				new_list = OrderProduct.new(order: new_order, product: Product.find(order_item[:qued_product].to_i), number_of_purchased: order_item[:quantity].to_i)
				new_list.save!
			end
			render json: @order
		end

		def order_history
			@order_history = @current_user.search
			render json: @order_history

		end

		def order_search
			start_date = Time.parse(params[:start_date])
			end_date = Time.parse(params[:end_date])
			timeframe = params[:timeframe]
			@results = @current_user.search_by_date(start_date, end_date, timeframe)
			render json: @results
		end

		def csv
			start_date = Time.parse(params[:start_date])
			end_date = Time.parse(params[:end_date])
			timeframe = params[:timeframe]
			@results = User.first.search_by_date(start_date, end_date, timeframe)
			@search_data = User.to_csv(@results)
			render json: @search_data
		end
		
		private

		def order_params
			# params.require(:order).permit(:order, items_purchased: {})
			params.require(:order).permit!
		end
		
	end
end