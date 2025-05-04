# frozen_string_literal: true

module Schemas
  module Categories
    def self.schema
      {
        category: {
          type: :object,
          properties: {
            id: { type: :string,
              format: :uuid,
              example: '123e4567-e89b-12d3-a456-426614174000' },
            name: { type: :string },
            slug: { type: :string },
            parent_id: { type: :uuid, nullable: true },
            created_at: { type: :string,
              format: 'date-time' },
            updated_at: { type: :string,
              format: 'date-time' }
          },
          required: %w[id name slug parent_id created_at updated_at]
        },
        categories: {
          type: :array,
          items: {
            "$ref" => '#/components/schemas/categories'
          }
        },
        categories_response: {
          type: :object,
          properties: {
            categories: {
              type: :array,
              items: {
                "$ref" => '#components/schemas/category'
              }
            },
            meta: {
              "$ref" => '#components/schemas/meta'
            }
          },
          required: %w[categories meta]
        }
      }
    end
  end
end
