# frozen_string_literal: true

module V1
  class UsersController < ApplicationController
    before_action :authorize, only: [:update]

    def show
      result = Users::Show.call(current_user:, params:)

      if result.success?
        user = result.value!
        render locals: { current_user:, user: }
      elsif result.failure?
        render json: { errors: result.failure }, status: :not_found
      end
    end

    def create
      result = Users::Create.call(params:)

      if result.success?
        user = result.value!
        render locals: { user: }
      elsif result.failure?
        render json: { errors: result.failure }, status: :unprocessable_entity
      end
    end

    def update
      result = Users::Update.call(current_user:, params: update_params)

      if result.success?
        render locals: { current_user: }
      elsif result.failure?
        render json: { errors: result.failure }, status: :unprocessable_entity
      end
    end

    private

    def update_params
      params.expect(data: %i[name email password password_confirmation])
    end
  end
end
