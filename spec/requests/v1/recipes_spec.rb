require 'swagger_helper'

RSpec.describe 'v1/recipes', type: :request do
  path '/v1/recipes' do
    get('list recipes') do
      parameter name: :page, in: :query, type: :integer,
        description: 'Page number'
      parameter name: :per_page, in: :query, type: :integer,
        description: 'Maximum number returned per page'

      response '200', 'recipes found' do
        let(:page) { 1 }
        let(:per_page) { 3 }
        schema "$ref" => '#/components/schemas/recipes'

        before do
          create_list(:recipes, 3)
        end

        run_test!(openapi_all_properties_required: true)
      end
    end
  end
end
