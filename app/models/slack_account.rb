class SlackAccount < ApplicationRecord
  belongs_to :user, default: -> { Current.user }

  def to_s
    name.presence || "SlackAccount##{id}"
  end
end
