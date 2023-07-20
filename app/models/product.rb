class Product < ApplicationRecord
  has_one :product_option, dependent: :destroy
  has_one :product_variant, dependent: :destroy
end
