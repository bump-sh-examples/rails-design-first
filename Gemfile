source "https://rubygems.org"

ruby "3.2.0"

gem "rails", "~> 7.1.2"
gem "sqlite3", "~> 1.4"
gem "puma", ">= 5.0"

gem 'pry', '~> 0.14.2'

gem 'openapi_first', '~> 1.0'
gem 'openapi_contracts', git: "git@github.com:philsturgeon/openapi_contracts.git"

group :test do
  gem 'rspec-rails', '~> 6.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[ mswin jruby ]

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false
