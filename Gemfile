# frozen_string_literal: true

source 'https://rubygems.org'

ruby '2.7.0'

gem 'aws-sdk-sns', '~> 1.22.0'
gem 'pg', '~> 1.2.3'
gem 'rake', '~> 13.0.1'
gem 'sinatra', '~> 2.0.8.1'
gem 'sinatra-activerecord', '~> 2.0.18'

group :development, :test do
  gem 'dotenv', '~> 2.7.5'
  gem 'factory_bot', '~> 5.1.2'
  gem 'pry', '~> 0.12.2'
end

group :development do
  gem 'rubocop', '~> 0.82.0', require: false
end

group :test do
  gem 'database_cleaner-active_record', '~> 1.8.0'
  gem 'rack-test', '~> 1.1.0'
  gem 'rspec', '~> 3.9.0'
end
