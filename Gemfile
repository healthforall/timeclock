source 'https://rubygems.org'
ruby '2.2.3'
# use Haml for templates
gem 'haml'
#To make time calculaitons easier
gem 'time_diff'
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.0'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc
# Authorization
gem "omniauth-google-oauth2"
# Hide mailers data
gem "figaro"
# ZIP Files
gem 'rubyzip' , :require => "zip"

group :development, :test do
  gem "rspec-rails", ">= 2.0.1"
  gem 'selenium-webdriver'
  gem 'factory_girl'
  gem 'factory_girl_rails'
  # Use sqlite3 as the database for Active Record
  gem 'sqlite3'
  # Call 'debugger' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'railroady'
end

group :production do
  gem 'pg'
  gem 'rails_12factor'
end

group :test do
  gem 'cucumber-rails', :require => false
  gem 'database_cleaner' # to clear Cucumber's test database between runs
  gem 'faker'            # generates names, email addresses, and other placeholders for factories
  gem 'capybara'         # lets Cucumber pretend to be a web browser
  gem 'launchy'          # a useful debugging aid for user stories
  gem 'guard-rspec'      # watches your app and tests and runs specs for you automatically when it detects changes
end


