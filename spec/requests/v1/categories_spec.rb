# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'v1/categories' do
  path '/v1/categories' do
    get('list categories') do
      response '200', 'categories found' do
        schema "$ref" => '#/components/schemas/categories_response'

        before do
          create_list(:category, 3)
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
