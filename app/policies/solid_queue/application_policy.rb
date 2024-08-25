# frozen_string_literal: true

module SolidQueue
  class ApplicationPolicy < ApplicationPolicy
    class Scope < ApplicationPolicy::Scope
      def resolve
        admin? ? scope.all : scope.none
      end
    end
  end
end
