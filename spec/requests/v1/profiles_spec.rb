# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'v1/profile/me' do
  path '/v1/profile/me' do
    get('show user profile') do
      consumes 'application/json'
      produces 'application/json'
      security [bearer_auth: []]

      let(:data) do
        { data: { name: 'john' } }
      end

      let(:Authorization) { login_token }

      response 200, 'successful' do
        schema "$ref" => "#/components/schemas/profile_show_response"
        run_test!
      end
    end

    get('show user profile not logged in') do
      response 401, 'unauthorized' do
        schema "$ref" => "#/components/schemas/profile_show_error_response"
        run_test! do |response|
          expect(JSON.parse(response.body)['errors']).to eq('Not logged in')
        end
      end
    end
  end
end
