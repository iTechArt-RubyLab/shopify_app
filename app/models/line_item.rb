class LineItem < ApplicationRecord
  belongs_to :order
  has_one :price_set, dependent: :destroy
end
