# frozen_string_literal: true

module V1
  class UsersController < ApplicationController
    skip_before_action :authorize
    def create
      user = Users::Create.call(params:)
      if user.persisted?
        render locals: { user: }
      else
        render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
      end
    end
  end
end
