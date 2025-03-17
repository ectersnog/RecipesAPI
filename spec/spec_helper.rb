# frozen_string_literal: true

require 'simplecov'
SimpleCov.start do
  add_filter %w[
    config/initializers
    spec/support
    spec/rails_helper.rb
  ]
end

require 'rspec-sidekiq'
require 'webmock/rspec'

WebMock.disable_net_connect!(allow_localhost: true)

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end
  config.filter_run_when_matching :focus
  config.disable_monkey_patching!
  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
  config.order = :random
  config.shared_context_metadata_behavior = :apply_to_host_groups

  Kernel.srand config.seed

  config.before(:suite) do
  end

  config.around(:each, :search) do |example|
  end
end

RSpec::Sidekiq.configure do |config|
  config.clear_all_enqueued_jobs = true
  config.enable_terminal_colours = true
  config.warn_when_jobs_not_processed_by_sidekiq = false
end
