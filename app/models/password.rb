# frozen_string_literal: true

class Password < ApplicationRecord
  belongs_to :user, default: -> { Current.user }

  has_secure_password

  def to_s
    hint.presence || "password##{id}"
  end
end
