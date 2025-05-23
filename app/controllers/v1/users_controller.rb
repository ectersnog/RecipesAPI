# frozen_string_literal: true

module V1
  class UsersController < ApplicationController
    before_action :authorize, only: [:update]

    def show
      user = Users::Show.call(current_user:, params:)
      if user
        render locals: { current_user:, user: }
      else
        render json: { errors: 'User not found' }, status: :not_found
      end
    end

    def create
      user = Users::Create.call(params:)
      if user.persisted?
        render locals: { user: }
      else
        render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
      end
    end

    def update
      Users::Update.call(current_user:, params: update_params)
      render locals: { user: current_user }
    rescue ActiveRecord::RecordInvalid => e
      render json: { errors: e.record.errors.full_messages }, status: :unprocessable_entity
    end

    private

    def update_params
      params.expect(data: %i[name email password password_confirmation])
    end
  end
end
