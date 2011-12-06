class ApplicationController < ActionController::Base
  protect_from_forgery

  layout :layout

  private

  def layout
    # only turn it off for login pages:
    #is_a?(Devise) ? "login" : "application"
    # or turn layout off for every devise controller:   
    #self.params.each do |x|
    #  puts "param: #{x}"
    #end

    session[:prev_path] = session[:current_path]
    session[:current_path] = request.env['PATH_INFO']

    devise_controller? ? deviseControllerLayout : "application"

    #return "application"
  end

  
  
  
  
  private 
  
  def deviseControllerLayout
    (is_a?(Devise::RegistrationsController) and (params[:action] == 'edit' or params[:action] = 'new')) ? 'application' : 'login' 
  end
end
