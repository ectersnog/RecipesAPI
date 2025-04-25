# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'v1/categories' do
  path '/v1/categories' do
    get('list categories') do
      response(200, 'successful') do
        schema "$ref" => '#/components/schemas/categories'

        run_test!
      end
    end
  end

  path '/v1/categories/{id}' do
    parameter name: 'id', in: :path, type: :string

    get('show category') do
      response(200, 'successful') do
        schema "$ref" => '#/components/schemas/category'

        let(:category) { create(:category) }
        let(:id) { category.id }

        run_test!
      end
    end
  end
end
