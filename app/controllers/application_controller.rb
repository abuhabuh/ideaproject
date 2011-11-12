class ApplicationController < ActionController::Base
  protect_from_forgery

  layout :layout

  private

  def layout
    # only turn it off for login pages:
    puts "controller is class::::::::::: #{self.class}"
    #is_a?(Devise) ? "login" : "application"
    # or turn layout off for every devise controller:
    devise_controller? ? "login" : "application"
  end
end
