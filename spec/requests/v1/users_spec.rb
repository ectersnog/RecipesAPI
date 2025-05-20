# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'v1/users' do
  path '/v1/users' do
    post('create user') do
      parameter name: :name, in: :query, type: :string
      parameter name: :email, in: :query, type: :string
      parameter name: :password, in: :query, type: :string

      response '200', 'user created' do
        let(:name) { FFaker::Name.first_name }
        let(:email) { FFaker::Internet.email }
        let(:password) { FFaker::Internet.password }

        run_test!
      end
    end
  end

  path '/v1/users/update' do
    put('update user') do
      parameter name: :data, in: :body, required: true, schema: {
        "$ref" => "#/components/schemas/user"
      }

      consumes 'application/json'
      produces 'application/json'
      security [bearer_auth: []]

      let(:data) do
        { data: { name: 'john' } }
      end

      let(:Authorization) { login_token }
      response '200', 'successful' do

        run_test!
      end
    end
    #
    # put('update user') do
    #   parameter name: :Authorization, in: :header, type: :string
    #   parameter name: :name, in: :query, type: :string
    #   parameter name: :email, in: :query, type: :string
    #   parameter name: :password, in: :query, type: :string
    #   response '200', 'successful' do
    #     let(:user) { create(:user) }
    #     let(:name) { user.name }
    #     let(:email) { user.email }
    #     let(:password) { user.password }
    #     let(:token) { Sessions::Create.call(params: { name:, email:, password: }) }
    #     let(:Authorization) { "Bearer #{token}" }
    #
    #     run_test!
    #   end
    # end

  end
end

