# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'v1/categories' do
  path '/v1/categories' do
    get('list categories') do
      response(200, 'successful') do
        schema "$ref" => '#/components/schemas/categories'

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end

        run_test!
      end
    end

    # post('create category') do
    #   response(200, 'successful') do
    #
    #     after do |example|
    #       example.metadata[:response][:content] = {
    #         'application/json' => {
    #           example: JSON.parse(response.body, symbolize_names: true)
    #         }
    #       }
    #     end
    #     run_test!
    #   end
    # end
  end

  path '/v1/categories/{slug}' do
    # You'll want to customize the parameter types...
    parameter name: 'slug', in: :path, type: :string, description: 'slug'

    get('show category') do
      response(200, 'successful') do
        schema "$ref" => '#/components/schemas/category'

        let!(:category) { create(:category, slug: '123') }
        let(:slug) { category.slug }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end

        run_test!
      end
    end

    # patch('update category') do
    #   response(200, 'successful') do
    #     let(:slug) { '123' }
    #
    #     after do |example|
    #       example.metadata[:response][:content] = {
    #         'application/json' => {
    #           example: JSON.parse(response.body, symbolize_names: true)
    #         }
    #       }
    #     end
    #     run_test!
    #   end
    # end
    #
    # put('update category') do
    #   response(200, 'successful') do
    #     let(:slug) { '123' }
    #
    #     after do |example|
    #       example.metadata[:response][:content] = {
    #         'application/json' => {
    #           example: JSON.parse(response.body, symbolize_names: true)
    #         }
    #       }
    #     end
    #     run_test!
    #   end
    # end
    #
    # delete('delete category') do
    #   response(200, 'successful') do
    #     let(:slug) { '123' }
    #
    #     after do |example|
    #       example.metadata[:response][:content] = {
    #         'application/json' => {
    #           example: JSON.parse(response.body, symbolize_names: true)
    #         }
    #       }
    #     end
    #     run_test!
    #   end
    # end
  end
end
