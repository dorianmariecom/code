# frozen_string_literal: true

class CountryCodePolicy < ApplicationPolicy
  def create?
    true
  end
end
