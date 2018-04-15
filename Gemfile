source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.3.3'

gem 'bootsnap', '>= 1.1.0', require: false
gem 'delayed_job', '~> 4.1.5'
gem 'delayed_job_active_record'
gem 'fast_jsonapi', '~> 1.1'
gem 'rails', '~> 5.2.0'
gem 'pg', '~> 1.0'
gem 'puma', '~> 3.11'
gem 'uglifier', '>= 1.3.0'
gem 'will_paginate', '~> 3.1.0'

gem 'rails_12factor', group: :production

group :development, :test do
  gem 'faker'
  gem 'pry-rails'
  gem 'rspec-rails', '~> 3.7'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'letter_opener'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
end

group :test do
  gem 'shoulda-matchers', '~> 3.1'
  gem 'factory_bot_rails'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
