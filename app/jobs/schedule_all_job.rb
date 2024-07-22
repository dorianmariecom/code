class ScheduleAllJob < ApplicationJob
  queue_as :default

  def perform
    Program.find_each(&:schedule!)
  end
end
