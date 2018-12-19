module Api::V1
	class ProductsController < ApplicationController
		def index
			@products = Category.find(params[:category_id]).products
			render json: @products		
		end
		private
	end
end