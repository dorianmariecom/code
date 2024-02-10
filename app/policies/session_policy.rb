class SessionPolicy < ApplicationPolicy
  def create?
    !current_user?
  end

  def destroy?
    current_user?
  end
end
