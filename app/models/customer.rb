class Customer < ApplicationRecord
  has_many :addresses, dependent: :destroy
  has_one :email_marketing_consent, dependent: :destroy
end
