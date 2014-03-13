class ApplicationController < ActionController::Base
  protect_from_forgery

  def load_current_quarter
    @current_quarter = Quarter.current
  end
end
