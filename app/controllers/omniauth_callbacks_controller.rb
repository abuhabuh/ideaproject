class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    @user = User.find_for_facebook_oauth(request.env["omniauth.auth"], current_user, request.env["omniauth.auth"]["provider"])
    
    flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Facebook"
    session["devise.facebook_data"] = request.env["omniauth.auth"] #TODO: Why stick everything in session?
    
    sign_in(@user)

    redirect_to authenticated_home_path
  end
end
