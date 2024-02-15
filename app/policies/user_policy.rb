# frozen_string_literal: true

class UserPolicy < ApplicationPolicy
  class Scope < ApplicationPolicy::Scope
    def resolve
      if admin?
        scope.all
      elsif current_user?
        scope.where(id: current_user)
      else
        scope.none
      end
    end
  end

  def index?
    admin?
  end

  def show?
    self? || admin?
  end

  def create?
    true
  end

  def update?
    self? || admin?
  end

  def destroy?
    self? || admin?
  end

  private

  def self?
    current_user? && record? && current_user == record
  end
end
