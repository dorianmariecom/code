# frozen_string_literal: true

module CanConcern
  private

  def can?(action, record)
    policy(record).public_send(:"#{action}?")
  end

  def cannot?(...)
    !can?(...)
  end

  def can!(action, record)
    authorize(record, :"#{action}?")
  end
end
