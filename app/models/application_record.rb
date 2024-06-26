# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  include Pundit::Authorization
  extend Pundit::Authorization

  primary_abstract_class

  def self.current_user
    Current.user
  end

  def alert
    errors.full_messages.to_sentence
  end

  def current_user
    Current.user
  end
end
