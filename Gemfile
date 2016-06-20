source 'https://rubygems.org'
ruby '2.2.0'

gem 'rails', '4.2.0'
gem 'rails-api'
gem 'responders', '~> 2.0'

# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'

gem 'pry-rails'

gem 'rack-cors', :require => 'rack/cors'

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
