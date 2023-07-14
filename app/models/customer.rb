class Customer< ActiveRecord::Base
  belongs_to :adress
  belongs_to :email_marketing_consent
  belongs_to :metafield
  belongs_to :sms_marketing_consent

end