Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
	namespace :api do
		namespace :v1 do
			resources :categories do
				resources :products
			end
			resources :orders
			post 'authenticate', to: 'authentication#authenticate'
			get 'all_products', to: 'products#all_products'
			get 'order_history', to: 'orders#order_history'
			post 'order_search', to: 'orders#order_search'
			get 'csv', to: 'orders#csv'
		end
	end
end
