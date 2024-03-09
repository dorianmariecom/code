class TwitterAccount < ApplicationRecord
  belongs_to :user, default: -> { Current.user }

  scope :primary, -> { where(primary: true) }
  scope :not_primary, -> { where(primary: false) }
  scope :verified, -> { where(verified: true) }
  scope :not_verified, -> { where(verified: false) }

  def self.verify!(code:)
  end

  def self.authorize_url
  end

  def self.client_id
  end

  def self.client_secret
  end

  def self.redirect_uri
  end

  def self.scope
  end

  def primary?
    !!primary
  end

  def not_primary?
    !primary?
  end

  def verified?
    !!verified
  end

  def not_verified?
    !verified?
  end

  def to_s
    "twitter_account##{id}"
  end
end
