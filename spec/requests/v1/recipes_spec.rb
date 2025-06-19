# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'v1/recipes' do
  path '/v1/recipes' do
    get('list recipes') do
      parameter name: :page, in: :query, type: :integer,
        description: 'Page number'
      parameter name: :per_page, in: :query, type: :integer,
        description: 'Maximum number returned per page'

      response '200', 'recipes found' do
        let(:page) { 1 }
        let(:per_page) { 3 }
        schema "$ref" => '#/components/schemas/recipes_response'

        before do
          create_list(:recipe, 3)
        end

        run_test!
      end
    end

    post('create recipe') do
      parameter name: :data, in: :formData, required: true, schema: {
        "$ref" => '#/components/schemas/recipes_create'
      }

      consumes 'multipart/form-data'
      # parameter name: :data, in: :formData, schema: {
      #   type: :object,
      #   properties: {
      #     data: {
      #       type: :object,
      #       properties: {
      #         cover_photo: { type: :file }
      #       }
      #     }
      #   }
      # }
      # parameter name: :'data[cover_photo]', in: :formData, type: :file, required: true

      # consumes 'application/json'
      produces 'application/json'
      security [bearer_auth: []]

      let(:Authorization) { login_token }
      let(:data) do
        attributes_for(:recipe).merge(
            ingredients: ['1 lb of nachos'],
            cover_photo: Rack::Test::UploadedFile.new(Rails.root.join('spec/media/image.jpg'))
          )
      end

      response 200, 'successful' do
        schema "$ref" => '#/components/schemas/recipe'
        run_test!
      end
    end
  end

  path '/v1/recipes/{id}' do
    parameter name: 'id', in: :path, type: :string

    get('show recipe') do
      response 200, 'successful' do
        schema "$ref" => '#/components/schemas/recipe'

        let(:recipe) { create(:recipe) }
        let(:id) { recipe.id }

        run_test!
      end

      response 404, 'not found' do
        schema "$ref" => '#/components/schemas/error_response'
        let(:id) { 'invalid' }

        run_test!
      end
    end
  end
end
