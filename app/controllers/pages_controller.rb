class PagesController < ApplicationController
  before_action { authorize :page }
  skip_after_action :verify_policy_scoped

  layout "empty", only: :up

  def home
  end

  def up
  end
end
