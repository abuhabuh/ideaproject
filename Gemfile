source 'http://rubygems.org'

gem 'rails', '3.1.1'

# Bundle edge Rails instead:
# gem 'rails',     :git => 'git://github.com/rails/rails.git'

gem 'pg' # driver for postgresql
gem 'json'
gem 'devise' # authentication package
gem 'foreigner' # foreign key for database
gem 'paperclip', '~> 2.4' # for fast pic attachments - uses file system though
                          #   need a better way to do this in DB
                          
gem 'heroku' # actually had to manually run 'gem install heroku' after bundle
             #   install to get it to find heroku executable
gem 'aws-s3' # integration with Amazon s3 storage for test and prod environments
             #   Nov 1 2011 djmnemonic s3 account activated

# CHAT CLIENT GEMS
# Juggernaut chat client - failed on Win 7
#gem 'gemcutter' # for juggernaut install requirement
#gem 'eventmachine', '1.0.0.beta.3' # eventmachine version that works with windows
#gem 'juggernaut_rails' # for juggernaut chat client
# Faye chat client setup - couldn't deploy to Heroku easily
#gem 'eventmachine', '1.0.0.beta.3' # eventmachine version that works with windows
#gem 'faye'
# Pusher chat client setup - current solution
gem 'pusher'
gem 'pusher-client'

# SEARCH GEMS
gem 'sunspot_rails'
gem 'will_paginate'

# TEST GEM INSTALL <BEGIN>
#group :development do
#  gem 'rspec-rails', '2.6.1'
#end
#
#group :test do
#  gem 'rspec-rails', '2.6.1'
#  gem 'webrat', '0.7.1'
#end
#
#gem 'autotest-standalone'
#gem 'autotest-rails-pure', '4.1.2'
#gem 'autotest-growl'
#
#
# TEST GEM INSTALL <END>


# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.1.4'
  gem 'coffee-rails', '~> 3.1.1'
  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'

group :test do
  # Pretty printed test output
  gem 'turn', :require => false
end
