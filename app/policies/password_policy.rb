class PasswordPolicy < ApplicationPolicy
  class Scope < ApplicationPolicy::Scope
    def resolve
      scope.where(user: policy_scope(User))
    end
  end
end
