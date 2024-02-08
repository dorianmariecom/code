class User < ApplicationRecord
  has_many :email_addresses
  belongs_to :primary_email_address, class_name: "EmailAddress", optional: true
end
