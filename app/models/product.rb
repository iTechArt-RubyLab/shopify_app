class Product < ApplicationRecord
  has_many :product_options, dependent: :destroy
  has_many :product_variants, dependent: :destroy
end
