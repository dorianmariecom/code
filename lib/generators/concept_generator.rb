class ConceptGenerator < Rails::Generators::NamedBase
  argument :attributes, type: :array, default: [], banner: "field[:type][:index] field[:type][:index]"

  def generate_model
    rails_command("generate model #{class_name} #{attributes.join(" ")}")
  end

  def generate_policy
    create_file "app/policies/#{file_name}_policy.rb", <<~RUBY
      class #{class_name}Policy < ApplicationPolicy
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
          owner? || admin?
        end

        private

        def user
          record? && record.user
        end

        def owner?
          user? && current_user? && user == current_user
        end
      end
    RUBY
  end

  def generate_controller
  end

  def generate_views
  end

  def generate_link
  end
end
