source 'https://rubygems.org'

ruby "2.0.0"

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.0'

gem 'newrelic_rpm'

# Use postgresql as the database for Active Record
gem 'pg', '0.16.0'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.0'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

gem 'kaminari'

gem 'textacular', "~> 3.0", require: 'textacular/rails'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

# Use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

group :production do
  # Use unicorn as the app server
  gem 'unicorn', group: :production
  # need by heroku
  gem 'rails_12factor'
end

# Use Capistrano for deployment
# gem 'capistrano', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]

gem 'bootstrap-sass'
gem 'simple_form'
gem 'slim-rails'
gem "paperclip", "~> 3.0"

gem 'devise', '~> 3.0.0'

group :development do
  gem "better_errors"
  gem "binding_of_caller"
  gem 'guard-rspec'
  gem 'pry-rails'
  gem 'pry-debugger'
end

group :development, :test do
  gem 'rspec-rails', '~> 2.0'
  gem 'factory_girl_rails'
  gem 'launchy'
end

group  :test do
  gem 'shoulda-matchers'
  gem 'capybara'
  gem "selenium-webdriver", "~> 2.33.0"
end


