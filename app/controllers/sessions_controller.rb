class SessionsController < ApplicationController
  def destroy
    reset_session

    redirect_to root_path, notice: t(".notice")
  end
end
