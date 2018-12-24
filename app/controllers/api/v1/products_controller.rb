module Api::V1
	class ProductsController < ApplicationController
		def index
			@products = Category.find(params[:category_id]).products
			render json: @products		
		end

		def all_products
			@all_products = Product.all
			render json: @all_products
		end
	end
end