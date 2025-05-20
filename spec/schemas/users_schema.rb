# frozen_string_literal: true

module Schemas
  module Users
    def self.schema
      {
        user: {
          type: :object,
          properties: {
            name: { type: :string },
            email: { type: :string },
            password: { type: :string },
            password_confirmation: { type: :string }
          },
          required: []
        }
      }
    end
  end
end
