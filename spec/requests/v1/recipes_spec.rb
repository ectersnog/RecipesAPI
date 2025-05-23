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
