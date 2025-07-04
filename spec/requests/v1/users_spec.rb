# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'v1/users' do
  path '/v1/users' do
    post('create user') do
      parameter name: :name, in: :query, type: :string
      parameter name: :email, in: :query, type: :string
      parameter name: :password, in: :query, type: :string

      response 200, 'user created' do
        let(:name) { FFaker::Name.first_name }
        let(:email) { FFaker::Internet.email }
        let(:password) { FFaker::Internet.password }
        schema "$ref" => '#/components/schemas/user_create_response'

        run_test!
      end

      response 422, 'unprocessable entity' do
        let(:name) { nil }
        let(:email) { FFaker::Internet.email }
        let(:password) { nil }
        schema "$ref" => '#/components/schemas/error_response'
        run_test!
      end
    end
  end

  path '/v1/users/{id}' do
    get('show user') do
      parameter name: :id, in: :path, type: :string

      let(:user) { create(:user) }

      response 200, 'successful' do
        schema "$ref" => "#/components/schemas/user_show_response"
        let(:id) { user.id }

        run_test!
      end

      response 404, 'errors' do
        let(:id) { 'invalid' }
        run_test!
      end
    end
  end

  path '/v1/users/update' do
    put('update user') do
      parameter name: :data, in: :body, required: true, schema: {
        "$ref" => "#/components/schemas/user_update"
      }

      consumes 'application/json'
      produces 'application/json'
      security [bearer_auth: []]

      let(:data) do
        { data: { name: 'john' } }
      end

      let(:Authorization) { login_token }

      response 200, 'successful' do
        schema "$ref" => "#/components/schemas/user_update_response"
        run_test!
      end
    end
  end
end
