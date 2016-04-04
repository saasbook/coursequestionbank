source 'https://rubygems.org'

ruby '2.2.2'
gem 'rails', '3.2.16'
# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'ruql', :git =>'https://github.com/zhangaaron/ruql.git'
gem 'omniauth'
gem 'cancan'
gem 'omniauth-github'
gem 'bootstrap-sass', '~> 3.3.3'
gem 'barista'
gem 'sunspot_rails', :git => 'https://github.com/sunspot/sunspot.git'
gem 'progress_bar'
gem 'json'
gem 'will_paginate'
gem 'sunspot_solr'
gem "codeclimate-test-reporter", group: :test, require: nil

group :test do
  gem 'cucumber-rails', :require => false
end

group :development, :test do
  gem 'sqlite3'
  #gem 'ruby-debug19'
  gem 'byebug'
  gem 'database_cleaner'
  gem 'rspec-rails'
  gem 'simplecov'
  gem 'rack_session_access'
  gem 'test-unit'
end

group :production do
  gem 'pg'
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  #gem 'therubyracer'
  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby
  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'
gem 'haml'
gem 'zeroclipboard-rails'
gem 'test-unit'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'debugger'
