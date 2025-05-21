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
        },
        user_create_response: {
          type: :object,
          properties: {
            data: {
              type: :object,
              properties: {
                id: { type: :string,
                      format: :uuid,
                      example: '123e4567-e89b-12d3-a456-426614174000' },
                name: { type: :string },
                email: { type: :string }
              }
            }
          }
        },
        user_update_response: {
          type: :object,
          properties: {
            data: {
              type: :object,
              properties: {
                id: { type: :string,
                      format: :uuid,
                      example: '123e4567-e89b-12d3-a456-426614174000' },
                name: { type: :string },
                email: { type: :string }
              }
            }
          }
        }
      }
    end
  end
end
