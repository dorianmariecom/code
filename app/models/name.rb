class Name < ApplicationRecord
  belongs_to :user, default: -> { Current.user }

  validate { can!(:update, user) }

  before_update do
    unverify! if name_changed? && verified?
  end

  def unverify!
    update!(verified: false)
  end

  def to_s
    name.presence || "name##{id}"
  end
end
