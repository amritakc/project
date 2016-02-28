class Purchase < ActiveRecord::Base
  belongs_to :user
  belongs_to :product
  # has_many :products_purchased through :purchases, source :users
end
