# frozen_string_literal: true

class StaticPolicy < ApplicationPolicy
  def up?
    true
  end

  def about?
    true
  end

  def terms?
    true
  end

  def privacy?
    true
  end

  def source?
    true
  end
end
