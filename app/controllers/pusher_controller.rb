class PusherController < ApplicationController
  protect_from_forgery :except => :auth # stop rails CSRF protection for this action
  
  # auth is setup for presence channel communication. does this work with
  #   private channel too? I dunno...TODO: find out
  def auth
    if current_user
      response = Pusher[params[:channel_name]].authenticate(params[:socket_id], {
        :user_id => current_user.id, # => required
        :user_info => { # => optional - for example
          :name => current_user.user_name,
          :email => current_user.email
        }
      })
      render :json => response
    else
      render :text => "Not authorized", :status => '403'
    end
  end
end
