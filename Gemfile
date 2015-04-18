source 'https://rubygems.org'

gem 'rails-i18n'
gem 'foreigner'
gem 'carrierwave'
gem 'rmagick'
gem 'gravtastic'
gem 'devise'
gem 'koala'
gem 'omniauth'
gem 'omniauth-facebook'
gem 'omniauth-twitter'
gem 'letter_opener'
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.8'

# Use mysql as the database for Active Record
gem 'mysql2'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.2'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
gem 'therubyracer', platforms: :ruby
gem 'less-rails' # Railsでlessを使えるようにする。Bootstrapがlessで書かれているため
gem 'twitter-bootstrap-rails' # Bootstrapの本体

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

group :development do
	gem 'bullet'
end

group :development, :test do
 gem "rspec-rails", "~> 2.14.0"
 gem "factory_girl_rails", "4.2.1"
 gem "spork-rails",github: "sporkrb/spork-rails"
 gem "guard-spork"
end

group :test do
  gem "faker", "~> 1.1.2"
	gem 'guard-rspec'
	gem 'spork',">0.9.0.rc"
  gem "capybara", "~> 2.1.0"  
  gem "database_cleaner", "~> 1.0.0"
  gem "launchy", "~> 2.3.0"
  gem "selenium-webdriver", "~> 2.39.0"
end
