# frozen_string_literal: true

module V1
  class SessionsController < ApplicationController
    def create
      session = Sessions::Create.call(params:)
      if session.nil?
        render json: { error: 'bad username or password' }, status: :unauthorized
      else
        render locals: { session: }
      end
    end
  end
end
