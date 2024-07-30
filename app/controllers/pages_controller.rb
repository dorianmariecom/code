# frozen_string_literal: true

class PagesController < ApplicationController
  before_action { authorize :page }
  skip_after_action :verify_policy_scoped

  layout "empty", only: :up

  def home
    @program = Program.new
  end

  def up
  end

  def about
  end

  def terms
  end

  def privacy
  end
end
