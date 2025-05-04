# frozen_string_literal: true

module Schemas
  module Recipes
    def self.schema
      {
        recipe: {
          type: :object,
          properties: {
            id: { type: :string,
              format: :uuid,
              example: '123e4567-e89b-12d3-a456-426614174000' },
            name: { type: :string },
            user_id: { type: :string,
              format: :uuid,
              example: '123e4567-e89b-12d3-a456-426614174000' },
            description: { type: :string },
            steps: { type: :array,
              items: { type: :string } },
            is_gluten_free: { type: :boolean },
            is_carb_free: { type: :boolean },
            is_kosher: { type: :boolean },
            is_paleo: { type: :boolean },
            is_vegetarian: { type: :boolean },
            is_vegan: { type: :boolean },
            slug: { type: :string },
            created_at: { type: :string,
              format: 'date-time' },
            updated_at: { type: :string,
              format: 'date-time' }
          },
          required: %w[id name slug created_at updated_at]
        },
      recipes_response: {
        type: :object,
        properties: {
          recipes: {
            type: :array,
            items: {
              "$ref" => '#/components/schemas/recipe'
            }
          },
          meta: {
            "$ref" => '#/components/schemas/meta'
          }
        },
        required: %w[recipes meta]
      }
    }
    end
  end
end
