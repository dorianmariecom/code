class Location < ApplicationRecord
  belongs_to :user, default: -> { Current.user }

  validate { can!(:update, user) }

  def to_s
    location.presence || "location##{id}"
  end
end
