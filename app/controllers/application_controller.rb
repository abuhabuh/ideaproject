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

    #do not add the session timeout url to the previous path otherwise the user will be redirected there after logging in again
    if request.env['PATH_INFO'] != '/home/session_timeout' 
      session[:prev_path] = session[:current_path]
      session[:current_path] = request.env['PATH_INFO']
    end

    #puts "current: " + session[:current_path] +" previous: "+ session[:prev_path] 

    devise_controller? ? deviseControllerLayout : "application"

    #return "application"
  end

  
  
  
  
  private 
  
  def deviseControllerLayout
    (is_a?(Devise::RegistrationsController) and (params[:action] == 'edit' or params[:action] = 'new')) ? 'application' : 'login' 
  end
end
