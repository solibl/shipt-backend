require 'faker'
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Wipe Database with seeded information
User.destroy_all

Category.destroy_all

Product.destroy_all

Status.destroy_all

User.create(first_name: 'John', last_name: 'Smith', password: 'password', email: 'test@shiptdev.com')

Category.create(name: 'Bouquets')

list_of_flowers = ['Dahlia','Daisy','Violet','Rose','Lily']
weights = [0.35, 1.42, 5.13,4.12, 0.16, 0.75]
list_of_flowers.each do |flower|
	product = Product.new(name: flower, weight: weights.sample)
	product.category = Category.all.first
	product.save!
end

Category.create(name: 'Instrument')

list_of_instruments = ['Flute', 'Violin', 'Harp', 'Ukelele', 'Oboe', 'Harmonica', 'Xylophone']
list_of_instruments.each do |instrument| 
	product = Product.new(name: instrument)
	product.category = Category.find_by(name: 'Instrument')
	product.save!
end

Category.create(name: 'Ingredients')

list_of_ingredients = ['Flour','Sugar','Salt','Pepper','Butter']
weights = [1.35, 2.42, 1.13,1.12, 1.16, 1.75]
list_of_ingredients.each do |ingredient|
	product = Product.new(name: ingredient, weight: weights.sample)
	product.category = Category.find_by(name: 'Ingredients')
	product.save!
end

list_of_statuses = ['Waiting for delivery', 'On its way', 'Delivered']
list_of_statuses.each do |status|
	new_status = Status.new(name: status)
	new_status.save!
end

current_user = User.first
all_products = Product.all
all_statuses = Status.all

20.times do 
	random_product = all_products.sample
	new_date = Faker::Date.between(10.days.ago, Date.today).to_time 
	new_order = Order.create(user: current_user, status: all_statuses.sample, created_at: new_date)
	new_list = OrderProduct.new(order: new_order, product: random_product, number_of_purchased: Random.rand(1..30))
	new_list.created_at = new_date
	new_list.save!
end