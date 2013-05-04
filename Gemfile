source 'https://rubygems.org'

gem 'rails', '3.2.8'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'sqlite3'

# js something somehting
gem 'execjs' # pick a suitable js engine, rake needs it
gem 'therubyracer'


# Gems used only for assets and not required
# in production environments by default.
group :assets do
	gem 'sass-rails',		'~> 3.2.3'
	#gem 'coffee-rails', '~> 3.2.1'

	# See https://github.com/sstephenson/execjs#readme for more supported runtimes
	# gem 'therubyracer', :platforms => :ruby

	gem 'uglifier', '>= 1.0.3'
end


group :development do
	gem 'guard-rspec'
	gem 'guard-cucumber'
	gem 'guard-livereload'
	
	# guard fs listeners
	gem 'rb-inotify', :require => false
	gem 'rb-fsevent', :require => false
	gem 'rb-fchange', :require => false
	# add growl support
	gem 'growl', :require => false
end

group :production do
	gem 'mysql2'
	gem 'passenger', '~> 3.0.19s'
end


gem 'jquery-rails'
gem 'mini_magick'
# To use ActiveModel has_secure_password
gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# do not use unicorn as it won't work on windows
#gem 'unicorn'

# Deploy with Capistrano
gem 'capistrano'

# To use debugger
# gem 'debugger'

# To use markup text format "markdown"
gem 'redcarpet'
gem 'albino'
gem 'carrierwave'

# test
gem "rspec-rails", ">= 2.10.1", :group => [:development, :test]
gem "factory_girl_rails", ">= 3.3.0", :group => [:development, :test]
gem "email_spec", ">= 1.2.1", :group => :test
gem "cucumber-rails", ">= 1.3.0", :group => :test, :require => false
gem "capybara", ">= 1.1.2", :group => :test
gem "database_cleaner", ">= 0.7.2", :group => :test
gem "launchy", ">= 2.1.0", :group => :test
gem 'simplecov', :require => false, :group => :test

# documentation
gem "yard", ">= 0.8.3"

#authentication
gem "devise", ">= 2.1.0"
gem "devise_invitable", "~> 1.0.0"

#search
gem "acts_as_indexed", "~> 0.8.1"

# json
gem "json", '~> 1.7.5'
