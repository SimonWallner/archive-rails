source 'https://rubygems.org'
ruby "1.9.3"

gem 'rails', '3.2.8'

# heroku default production server
gem 'unicorn'

# js something somehting
# gem 'execjs' # pick a suitable js engine, rake needs it
# gem 'therubyracer'


# Gems used only for assets and not required
# in production environments by default.
group :assets do
	gem 'sass-rails',		'~> 3.2.3'
	#gem 'coffee-rails', '~> 3.2.1'


	gem 'uglifier', '>= 1.0.3'
end


group :development do
	gem 'sqlite3'
	
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
	gem 'pg' # heroku uses postgreSQL
	gem 'newrelic_rpm'
end


gem 'jquery-rails', "~> 2.1"
gem 'jquery-ui-rails'
gem 'mini_magick'

# To use ActiveModel has_secure_password
gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'


# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'debugger'

# To use markup text format "markdown"
gem 'redcarpet'
gem 'albino'

gem 'carrierwave'
gem 'fog', '~> 1.12.1'

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
gem "devise", "~> 2.1"
gem "devise_invitable", "~> 1.0.0"

#search
gem "acts_as_indexed", "~> 0.8.1"

# json
gem "json", '~> 1.7.5'
