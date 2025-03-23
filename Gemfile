# frozen_string_literal: true

source "https://rubygems.org"

gem "active_model_serializers"
gem "bcrypt", "~> 3.1.7"
gem "bootsnap", require: false
gem "dry-initializer"
gem "dry-initializer-rails"
gem "dry-operation"
gem "dry-schema"
gem "friendly_id"
gem "jsonb_accessor"
gem "kaminari"
gem "marcel"
gem "pg", "~> 1.1"
gem "puma", ">= 5.0"
gem "rack-cors"
gem "rails", "~> 8.0.2"

group :development do
  gem "annotate"
end

group :development, :test do
  gem "brakeman"
  gem "debug", platforms: %i[mri mingw x64_mingw]
  gem "dotenv-rails"
  gem "factory_bot_rails"
  gem "ffaker"
  gem "pry"
  gem "rspec-rails"
  gem "rswag-specs"
  gem "rubocop-factory_bot"
  gem "rubocop-rails", require: false
  gem "rubocop-rspec", require: false
  gem "rubocop-rspec_rails", require: false
end

group :test do
  gem "database_cleaner-active_record"
  gem "rspec-sidekiq", require: false
  gem "shoulda-matchers"
  gem "simplecov", require: false
  gem "webmock"
end

gem "shrine", "~> 3.6"

gem "image_processing", "~> 1.14"

gem "ingreedy", "~> 0.1.0"
