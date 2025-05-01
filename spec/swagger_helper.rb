# frozen_string_literal: true

require 'rails_helper'

RSpec.configure do |config|
  # Specify a root folder where Swagger JSON files are generated
  # NOTE: If you're using the rswag-api to serve API descriptions, you'll need
  # to ensure that it's configured to serve Swagger from the same folder
  config.openapi_root = Rails.root.join('swagger').to_s

  # Define one or more Swagger documents and provide global metadata for each one
  # When you run the 'rswag:specs:swaggerize' rake task, the complete Swagger will
  # be generated at the provided relative path under openapi_root
  # By default, the operations defined in spec files are added to the first
  # document below. You can override this behavior by adding a openapi_spec tag to the
  # the root example_group in your specs, e.g. describe '...', openapi_spec: 'v2/swagger.json'
  config.openapi_specs = {
    'v1/swagger.yaml' => {
      openapi: '3.0.1',
      info: {
        title: 'API V1',
        version: 'v1'
      },
      components: {
        schemas: {
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
          meta: {
            type: :object,
            properties: {
              current_page: { type: :integer },
              total_pages: { type: :integer },
              records: { type: :integer },
              total_records: { type: :integer }
            },
            required: %w[current_page total_pages records total_records]
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
          },
          categories_response: {
            type: :object,
            properties: {
              categories: {
                type: :array,
                items: {
                  "$ref" => '#/components/schemas/category'
                }
              },
              meta: {
                "$ref" => '#/components/schemas/meta'
              }
            },
            required: %w[categories meta]
          }
        }
      },
      paths: {},
      servers: [
        {
          url: 'http://{defaultHost}',
          variables: {
            defaultHost: {
              default: 'localhost:3400'
            }
          }
        }
      ]
    }
  }

  # Specify the format of the output Swagger file when running 'rswag:specs:swaggerize'.
  # The openapi_specs configuration option has the filename including format in
  # the key, this may want to be changed to avoid putting yaml in json files.
  # Defaults to json. Accepts ':json' and ':yaml'.
  config.openapi_format = :yaml
end
