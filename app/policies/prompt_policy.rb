# frozen_string_literal: true

class PromptPolicy < ApplicationPolicy
  class Scope < ApplicationPolicy::Scope
    def resolve
      scope.where(program: policy_scope(Program)).or(
        scope.where(user: policy_scope(User))
      )
    end
  end

  def index?
    current_user?
  end

  def show?
    can?(:show, program || user)
  end

  def create?
    true
  end

  def destroy?
    can?(:destroy, program || user)
  end

  def destroy_all?
    current_user?
  end

  private

  def program
    record.program
  end

  def user
    record.user
  end
end
