# frozen_string_literal: true

module V1
  class UsersController < ApplicationController
    def create
      session = Users::Create.call(params:)
      if session.nil?
        render json: { error: 'user already exists' }, status: :unprocessable_entity
      else
        render locals: { session: }
      end
    end
  end
end
