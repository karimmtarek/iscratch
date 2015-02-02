source 'https://rubygems.org'
ruby '2.2.0'

gem 'rails', '4.2.0'
gem 'rails-api'
gem 'responders', '~> 2.0'

# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

gem 'pry-rails'

gem 'rack-cors', :require => 'rack/cors'

# gem 'devise'
# gem 'simple_token_authentication', '~> 1.0'

group :development do
  gem 'thin'
  gem 'spring'
  gem 'guard-rspec', require: false
  gem 'faker'
  gem "better_errors"
end

group :test do
  gem 'rspec-rails', '~> 3.0'
  gem 'factory_girl_rails'
  gem 'simplecov', require: false
end

group :development, :test do
  gem 'sqlite3'
end

group :production do
  gem 'pg'
  gem 'rails_12factor'
  gem 'unicorn'
end

# To use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Deploy with Capistrano
# gem 'capistrano', :group => :development

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'
