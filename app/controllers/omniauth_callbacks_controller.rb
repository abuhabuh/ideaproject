class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    @user = User.find_for_facebook_oauth(request.env["omniauth.auth"], current_user, request.env["omniauth.auth"]["provider"])
    
    flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Facebook"
    session["devise.facebook_data"] = request.env["omniauth.auth"] #TODO: Why stick everything in session?
    
    sign_in(@user)

    current_uri = request.env['PATH_INFO']
    puts "PATH IS: "+current_uri+ " prev path: "+ session[:prev_path]

    #TODO: why redirect to previous path? Sign in should just go to auth home. 
    #      this is breaking sign in from middle of interest match
    redirect_to session[:prev_path].nil? ? authenticated_home_path : session[:prev_path]
  end
end
