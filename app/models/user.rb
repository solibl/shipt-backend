require 'csv'
class User < ApplicationRecord
	has_many :orders
	has_many :order_products
	has_secure_password

	def self.to_csv(results)
		attributes = results.first.keys
		
		file = CSV.generate(headers: true) do |csv|
			csv << attributes
			results.each do |row|
				csv << [row[:date], row[:category], row[:product], row[:quantity_sold]]
			end
		end
		file
	end	

	def search
		# results = ActiveRecord::Base.connection.execute('
		# 	SELECT U.id, U.first_name, C.id, C.name, OP.number_of_purchased
		# 	FROM Orders AS O
		# 	JOIN Users AS U ON  O.user_id = U.id
		# 	JOIN Products AS P ON P.id = U.id
		# 	JOIN Categories AS C ON P.id = C.id
		# 	JOIN Order_Products AS OP ON OP.order_id = O.id
		# 	')
		# p results.values

		list_of_ordered_items = []
		final_list = []
		Order.where(user_id: self).each do |ordered_items|
			order_number = ordered_items.id 
			products_in_order = OrderProduct.where(order_id: order_number)
			products_in_order.each do |ordered_product|
				product = Product.find(ordered_product.product_id)
				category = product.category
				quantity = ordered_product.number_of_purchased
				list_of_ordered_items << { product: product.name, purchased: quantity, category: category.name, date_ordered: ordered_items.created_at.in_time_zone("Pacific Time (US & Canada)").strftime("%m-%d-%Y")}
			end
			final_list << list_of_ordered_items
			list_of_ordered_items = []
		end
		final_list
	end

	def search_by_date(start_date, end_date, timeframe)
		final_list = []
		beginning_time = start_date
		orders_in_date = {}
		all_orders = Order.all.pluck(:id)
		all_products_purchased = OrderProduct.where(order_id: all_orders, created_at: start_date..end_date).pluck(:product_id)
		all_products_purchased = all_products_purchased.uniq
		if timeframe == 'Daily'
			timeframe_to_add = 1.day.to_i
			time_format = "%m-%d-%Y"
			date_range = beginning_time.beginning_of_day..beginning_time.end_of_day
		elsif timeframe =='Weekly'
			timeframe_to_add = 1.week.to_i
			time_format = "%m-%d-%Y"
			date_range = beginning_time.beginning_of_day..(beginning_time.beginning_of_day + timeframe_to_add)
		else
			timeframe_to_add = 1.month.to_i
			time_format = "%B"
			date_range = beginning_time.beginning_of_month..(beginning_time.end_of_month)
		end
		until beginning_time > end_date do
			all_products_purchased.each do |product|
				total_items_bought = OrderProduct.where(product_id: product, created_at: date_range).sum(:number_of_purchased)
				product_found = Product.find(product)
				if total_items_bought != 0
					orders_in_date = {
						date: beginning_time.strftime(time_format),
						product: product_found.name,
						category: product_found.category.name,
						quantity_sold: total_items_bought
					}
					final_list << orders_in_date
				end
			end
			beginning_time += timeframe_to_add
			if timeframe == 'Daily'
				date_range = beginning_time.beginning_of_day..beginning_time.end_of_day
			elsif timeframe =='Weekly'
				date_range = beginning_time.beginning_of_day..(beginning_time.beginning_of_day + timeframe_to_add)
			else
				date_range = beginning_time.beginning_of_month..(beginning_time.end_of_month)
			end
		end
		final_list
	end
end