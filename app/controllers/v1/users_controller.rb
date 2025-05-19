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
      user = Users::Update.call(params:)
      if user
        render json: { message: "Updated successfully" }
      else
        render json: { errors: "Unable to update" }, status: :unprocessable_entity
      end
    end
  end
end
