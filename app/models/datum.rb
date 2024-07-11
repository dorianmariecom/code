class Datum < ApplicationRecord
  belongs_to :user, default: -> { Current.user }

  def to_s
    data.to_json
  end
end
