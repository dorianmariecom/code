# frozen_string_literal: true

class SessionPolicy < ApplicationPolicy
  def create?
    true
  end

  def destroy?
    current_user?
  end
end
