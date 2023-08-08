class LineItem < ApplicationRecord
  belongs_to :order
  has_one :price_set, dependent: :destroy
  has_one :discount_allocation, dependent: :destroy
end
