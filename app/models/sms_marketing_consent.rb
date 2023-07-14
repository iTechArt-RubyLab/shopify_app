class SmsMarketingConsent < ActiveRecord::Base
  has_many :customers
end