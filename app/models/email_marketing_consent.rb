class EmailMarketingConsent < ApplicationRecord
  has_many :customers, dependent: :destroy
end
