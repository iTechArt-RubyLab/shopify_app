class Address < ApplicationRecord
  has_many :customers, dependent: :destroy
end
