class Purchase < ActiveRecord::Base
  belongs_to :users
  belongs_to :products
  # has_many :products_purchased through :purchases, source :users
end
