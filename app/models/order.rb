class Order < ApplicationRecord
	belongs_to :user
	belongs_to :status
	has_and_belongs_to_many :products
end
