class Datum < ApplicationRecord
  belongs_to :user, default: -> { Current.user }

  def data=(value)
    super(JSON.parse(value))
  rescue JSON::ParserError
    super(value)
  end

  def to_s
    data.to_json
  end
end
