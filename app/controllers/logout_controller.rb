class LogoutController < ApplicationController
  def index
    reset_session
    redirect_to root_path
  end
end
