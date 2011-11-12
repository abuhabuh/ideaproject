class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    @user = User.find_for_facebook_oauth(env["omniauth.auth"], current_user, "facebook")
  
    flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Facebook"
    session["devise.facebook_data"] = env["omniauth.auth"]
    
    sign_in(@user)
#    render 'users/facebook_callback'
    redirect_to authenticated_home_path
  end
end
