# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'v1/categories' do
  path '/v1/categories' do
    get('list categories') do
      parameter name: :page, in: :query, type: :integer,
        description: 'Page number'
      parameter name: :per_page, in: :query, type: :integer,
        description: 'Maximum number returned per page'

      response '200', 'categories found' do
        let(:page) { 1 }
        let(:per_page) { 3 }
        schema "$ref" => '#/components/schemas/categories_response'

        before do
          create(:category, name: 'Potatoes')
          create(:category, name: 'Tacos')
          create(:category, name: 'Pizza')
        end

        run_test!(openapi_all_properties_required: true)
      end
    end
  end

  path '/v1/categories/{id}' do
    parameter name: 'id', in: :path, type: :string

    get('show category') do
      response 200, 'successful' do
        schema "$ref" => '#/components/schemas/category'

        let(:category) { create(:category) }
        let(:id) { category.id }

        run_test!(openapi_all_properties_required: true)
      end
    end
  end
end
