# frozen_string_literal: true

class ExecutionPolicy < ApplicationPolicy
  class Scope < ApplicationPolicy::Scope
    def resolve
      scope.where(program: policy_scope(Program))
    end
  end
end
