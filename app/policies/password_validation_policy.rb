# frozen_string_literal: true

class PasswordValidationPolicy < ApplicationPolicy
  def create?
    true
  end
end
