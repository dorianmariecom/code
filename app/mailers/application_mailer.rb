# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: "dorian@codedorian.com"
  layout "mailer"
end
