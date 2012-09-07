class ApplicationController < ActionController::Base
  protect_from_forgery
  def initialize
    @org = W2g::Application.config.organization
    super
  end
end
