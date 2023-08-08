class Order < ApplicationRecord
  has_many :line_items, dependent: :destroy
  has_one :canceled_order
end
