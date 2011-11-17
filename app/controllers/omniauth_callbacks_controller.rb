class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    
    puts "****** in facebook function"
    puts "******   provider: " + request.env["omniauth.auth"]["provider"]
    
    
    @user = User.find_for_facebook_oauth(request.env["omniauth.auth"], current_user, request.env["omniauth.auth"]["provider"])
    
    puts "****** user found or created. user first name: " + @user.first_name
    
    flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Facebook"
    session["devise.facebook_data"] = request.env["omniauth.auth"]
    
    sign_in(@user)
#    render 'users/facebook_callback'

    puts "****** user signed in, redirecting to home page"

    redirect_to authenticated_home_path
  end
end
