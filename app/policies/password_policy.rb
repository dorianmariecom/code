class PasswordPolicy < ApplicationPolicy
  class Scope < ApplicationPolicy::Scope
    def resolve
      scope.where(user: policy_scope(User))
    end
  end

  def index?
    current_user?
  end

  def show?
    owner? || admin?
  end

  def create?
    current_user?
  end

  def update?
    owner? || admin?
  end

  def destroy?
    (owner? || admin?) && user.email_addresses.many?
  end

  private

  def user?
    !!user
  end

  def user
    record? && record.user
  end

  def owner?
    current_user? && user? && current_user == user
  end
end
