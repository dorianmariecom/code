class UserPolicy < ApplicationPolicy
  class Scope < ApplicationPolicy::Scope
    def resolve
      scope.where(id: current_user)
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
