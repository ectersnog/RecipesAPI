# frozen_string_literal: true

module V1
  class UsersController < ApplicationController
    before_action :authorize, only: [:update]
    def create
      user = Users::Create.call(params:)
      if user.persisted?
        render locals: { user: }
      else
        render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
      end
    end

    def update
      Users::Update.call(current_user: current_user, params: update_params)
      render locals: { user: current_user }
    rescue ActiveRecord::RecordInvalid => e
      render json: { errors: e.record.errors.full_messages }, status: :unprocessable_entity
    end

    def show
      user = Users::Show.call(current_user: current_user, params:)
      if user
        render locals: { current_user: current_user, user: }
      else
        render json: { errors: 'User not found' }, status: :unprocessable_entity
      end
    end

    private

    def update_params
      params.expect(data: %i[name email password password_confirmation])
    end
  end
end
