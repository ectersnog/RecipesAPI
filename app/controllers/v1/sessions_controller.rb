# frozen_string_literal: true

module V1
  class SessionsController < ApplicationController
    def create
      session = Sessions::Create.call(params:)
      if session.nil?
        render json: { error: 'user already exists' }, status: :unprocessable_entity
      else
        render locals: { session: }
      end
    end

    def login
      session = Sessions::Login.call(params:)
      if session.nil?
        render json: { error: 'bad username or password' }, status: :unauthorized
      else
        render locals: { session: }
      end
    end
  end
end
