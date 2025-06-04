# frozen_string_literal: true

module V1
  class TokensController < ApplicationController
    def create
      result = Tokens::Create.call(params:)
      if result.success?
        render locals: { token: result.success }
      elsif result.failure?
        render json: { error: 'bad username or password' }, status: :unauthorized
      end
    end
  end
end
