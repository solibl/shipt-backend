require 'faker'
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Wipe Database with seeded information
Customer.destroy_all

Category.destroy_all

Product.destroy_all

Customer.create(first_name: 'John', last_name: 'Smith', password: 'password', email: 'test@shiptdev.com')
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
	new_movie = Product.new(name: instrument)
	new_movie.category = Category.find_by(name: 'Instrument')
	new_movie.save!
end

Category.create(name: 'Ingredients')

list_of_ingredients = ['Flour','Sugar','Salt','Pepper','Butter']
weights = [1.35, 2.42, 1.13,1.12, 1.16, 1.75]
list_of_ingredients.each do |ingredient|
	product = Product.new(name: ingredient, weight: weights.sample)
	product.category = Category.find_by(name: 'Ingredients')
	product.save!
end
