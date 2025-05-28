# frozen_string_literal: true

module Sessions
  class Create < ApplicationOperation
    def initialize(params:)
      @params = params
    end

    def call
      user = User.find_by(email: @params[:email])
      return Failure(:not_authenticated) unless user && user.authenticate(@params[:password])

      JwtLib.token_encode(user)
    end
  end
end
