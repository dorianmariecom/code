# frozen_string_literal: true

class Password < ApplicationRecord
  has_secure_password

  belongs_to :user, default: -> { Current.user }, touch: true

  validate { can!(:update, user) }

  before_validation { self.user ||= User.create! }

  def to_s
    hint.presence || "password##{id}"
  end
end
