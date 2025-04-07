source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.2.2"

gem "rails", "~> 7.0.8", ">= 7.0.8.7"
gem "sprockets-rails"
gem "pg", "~> 1.1"
gem "puma", "~> 5.0"
gem 'concurrent-ruby', '1.3.4'
gem "redis", "~> 4.0"
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]
gem "bootsnap", require: false
gem 'csv', '~> 3.3', '>= 3.3.3'
gem 'parallel', '~> 1.26', '>= 1.26.3'
gem 'will_paginate', '~> 4.0', '>= 4.0.1'
gem 'rubyzip'

# Use Sass to process CSS
# gem "sassc-rails"

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"

group :development, :test do
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
  gem 'dotenv-rails',           '~> 2.7.6'
  gem 'factory_bot_rails',      '~> 6.2.0'
  gem 'rspec',                  '~> 3.11.0'
  gem 'rspec-rails',            '~> 5.1.2'
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
end
