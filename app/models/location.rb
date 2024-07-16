class Location < ApplicationRecord
  belongs_to :user, default: -> { Current.user }

  validate { can!(:update, user) }

  before_update do
    unverify! if location_changed? && verified?
  end

  def unverify!
    update!(verified: false)
  end

  def to_s
    location.presence || "location##{id}"
  end
end
