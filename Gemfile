source 'https://rubygems.org'

ruby '2.5.5'
gem 'rails', '4.2.9'

gem 'googlecharts', :git => 'https://github.com/mattetti/googlecharts.git'
# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'ruql', :git =>'https://github.com/stevenwuyinze/ruql'
gem 'protected_attributes'
gem 'activerecord-session_store'
gem 'omniauth'
gem 'cancan'
gem 'omniauth-github'
gem 'bootstrap-sass', '~> 3.3.3'
gem 'barista'
gem 'figaro'
gem 'sunspot_rails', :git => 'https://github.com/sunspot/sunspot.git'
gem 'progress_bar'
gem 'json'
gem 'will_paginate'
gem 'rollbar'
gem 'jquery-rails'
gem 'haml'
gem 'sassc-rails'
gem 'uglifier'
gem 'sidekiq' #ruby, '~> 3.5.4'
gem 'sidekiq-status'
gem 'sinatra', require: false
gem 'slim'

# Gems that bundle JS

group :development do
  gem 'bullet', '< 5.5.0'
end

group :development, :test do
  gem 'sunspot_solr'            # "not for use in production"
  gem 'cucumber-rails', :require => false
  gem "codeclimate-test-reporter", group: :test, require: nil
  gem 'coveralls', require: false
  gem 'rspec-rails'
  gem 'rails-erd'
  gem 'sqlite3', '~> 1.3.0'
  gem 'byebug'
  gem 'database_cleaner'
  gem 'simplecov'
  gem 'rack_session_access'
  gem 'poltergeist'
  gem 'phantomjs' #:require => 'phantomjs/poltergeist'
  gem 'jasmine'
  gem 'test-unit'
end

group :production do
  gem 'pg', '~> 0.15'
  gem 'rails_12factor'
end

