source 'http://rubygems.org'

gem 'rails', '3.1.1'

# Bundle edge Rails instead:
# gem 'rails',     :git => 'git://github.com/rails/rails.git'

gem 'mysql2' # driver for mysql
gem 'json'
gem 'devise' # authentication package
gem 'foreigner' # foreign key for database
gem 'paperclip', '~> 2.4' # for fast pic attachments - uses file system though
                          #   need a better way to do this in DB
                          
gem 'heroku' # actually had to manually run 'gem install heroku' after bundle
             #   install to get it to find heroku executable

# XXX CUDN'T INSTALL XXX Juggernaut chat client 
#gem 'gemcutter' # for juggernaut install requirement
#gem 'eventmachine', '1.0.0.beta.3' # eventmachine version that works with windows
#gem 'juggernaut_rails' # for juggernaut chat client

# Faye chat client setup
gem 'eventmachine', '1.0.0.beta.3' # eventmachine version that works with windows
gem 'faye'


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

# Gems for Heroku deployment
group :production do
  gem 'pg'
end