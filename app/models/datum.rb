class Datum < ApplicationRecord
  belongs_to :user, default: -> { Current.user }
end
