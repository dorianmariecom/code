class Datum < ApplicationRecord
  belongs_to :user, default: -> { Current.user }, touch: true

  validate { can!(:update, user) }

  before_validation { self.user ||= User.create! }

  def to_s
    data.to_json
  end
end
