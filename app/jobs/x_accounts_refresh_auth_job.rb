# frozen_string_literal: true

class XAccountsRefreshAuthJob < ApplicationJob
  queue_as :default

  def perform
    XAccount.find_each do |x_account|
      x_account.refresh_auth! if x_account.auth_expired?
    end
  end
end
