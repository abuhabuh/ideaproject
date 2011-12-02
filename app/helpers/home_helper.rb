module HomeHelper

  def link_to_readonly(force_login, *body, &block)
    if force_login
      body.each do |test|
        puts test
      end
      puts "INSPECT AGAIN!"
      if body[-1].is_a?(Hash)
        body[-1][:rel] = 'facebox'
        body[-1][:remote] = false
        body[-1][:method] = 'get'  
        body[-2] =  :new_user_session
      else
        body[-1] =  :new_user_session
      end
 
      body.inspect
      link_to *body, &block 
    else
      link_to *body, &block
    end
  end

end
