class SessionTimeoutFailureApp < Devise::FailureApp
  def redirect
    message = warden.message || warden_options[:message]
    if message == :timeout
      redirect_to session_timeout_path 
    else
      super
    end
  end
end
