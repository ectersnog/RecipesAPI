# frozen_string_literal: true

# Load .env file for development and test environments
Dotenv::Rails.load if Rails.env.local?

# List of required keys for operation
Dotenv.require_keys("DATABASE_URL")
