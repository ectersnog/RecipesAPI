# frozen_string_literal: true

require_relative 'boot'

require 'rails'
require 'active_model/railtie'
require 'active_record/railtie'
require 'action_controller/railtie'
require 'action_mailer/railtie'
require 'action_view/railtie'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

# Load .env file for development and test environments
if Rails.env.development? || Rails.env.test?
  Dotenv::Rails.load
end

module RecipesAPI
  class Application < Rails::Application
    config.load_defaults 8.0
    config.autoload_lib(ignore: %w[assets tasks])
    config.time_zone = 'UTC'
    config.api_only = true
    config.generators do |g|
      g.helper false
      g.orm :active_record, primary_key_type: :uuid
    end
  end
end
