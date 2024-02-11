class PagesController < ApplicationController
  before_action { authorize :page }
  skip_after_action :verify_policy_scoped

  layout "empty", only: :up

  PROGRAM_INPUT = <<~CODE
    Email.send(
      to: "dorian@dorianmarie.com",
      subject: "Hello",
      body: "What's up?"
    )
  CODE

  def home
    @program = Program.new(input: PROGRAM_INPUT)
  end

  def up
  end
end
