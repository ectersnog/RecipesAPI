# frozen_string_literal: true

require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'

require_relative '../config/environment'

abort('The Rails environment is running in production mode!') if Rails.env.production?
require 'database_cleaner/active_record'
require 'rspec/rails'
require 'rspec-sidekiq'

DatabaseCleaner.strategy = :truncation
DatabaseCleaner.clean

Rails.root.glob('spec/support/**/*.rb').each { |f| require f }

begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end

RSpec.configure do |config|
  config.include AuthHelpers
  config.include Rails.application.routes.url_helpers, type: :request
  config.include FactoryBot::Syntax::Methods
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
  config.use_transactional_fixtures = true
end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end
