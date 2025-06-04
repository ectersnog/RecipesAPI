# frozen_string_literal: true

module Tokens
  class Create < ApplicationOperation
    def call(params:)
      user = User.find_by(email: params[:email])
      password = params[:password]
      step check_auth_and_user(user, password)
    end

    private

    def check_auth_and_user(user, password)
      if user && user.authenticate(password)
        Success(JwtLib.token_encode(user))
      end
      Failure(:not_found)
    end
  end
end
