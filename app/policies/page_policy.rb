class PagePolicy < ApplicationPolicy
  def home?
    true
  end

  def up?
    true
  end

  def documentation?
    true
  end
end
