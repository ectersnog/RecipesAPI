# frozen_string_literal: true

module Schemas
  module Profiles
    def self.schema
      {
        profile_show_response: {
          type: :object,
          properties: {
            data: {
              type: :object,
              properties: {
                id: { type: :string },
                name: { type: :string },
                email: { type: :string }
              }
            }
          }
        },
        profile_show_error_response: {
          type: :object,
          properties: {
            errors: { type: :string }
          }
        }
      }
    end
  end
end
