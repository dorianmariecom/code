class PagesController < ApplicationController
  before_action { authorize :page }
  skip_after_action :verify_policy_scoped

  layout "empty", only: :up

  def home
    @program = Program.new
  end

  def up
  end
end
