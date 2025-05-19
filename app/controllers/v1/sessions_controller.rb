# frozen_string_literal: true

module V1
  class SessionsController < ApplicationController
    def create
      session = Sessions::Create.call(params:)
      if session
        render locals: { session: }
      else
        render json: { error: 'bad username or password' }, status: :unauthorized
      end
    end
  end
end
