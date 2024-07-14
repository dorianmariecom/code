# frozen_string_literal: true

class Password < ApplicationRecord
  has_secure_password

  belongs_to :user, default: -> { Current.user }

  validate { can!(:update, user) }

  def to_s
    hint.presence || "password##{id}"
  end
end
