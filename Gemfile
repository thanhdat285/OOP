source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.1.3'
gem 'puma', '~> 3.7'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'

# gem 'pg', '0.18.4'
gem "mysql2"
gem "config"
gem "byebug"
gem 'jquery-rails'
gem "bootstrap-sass", "~> 3.3.7"
gem "font-awesome-rails"
gem 'jwt', '1.5.6'
gem "will_paginate"
gem "bulk_insert"

gem "rack-cors"

group :development, :test do
  gem 'capybara', '~> 2.13'
  gem 'selenium-webdriver'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'railroady'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
