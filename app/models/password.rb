class Password < ApplicationRecord
  belongs_to :user, default: -> { Current.user }

  has_secure_password

  def to_s
    "Password##{id}"
  end
end
