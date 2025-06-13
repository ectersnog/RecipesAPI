# frozen_string_literal: true

module Tokens
  class Create < ApplicationOperation
    # Creates an authorization token
    #
    # @param params [Hash]
    # @option params [String] :email Email address to log in with
    # @option params [String] :password Password to log in with
    #
    # @return [JWT] JWT token with user_id and expiration date encoded on success, :not_found on failure
    def call(params:)
      user = User.find_by(email: params[:email])
      password = params[:password]
      step check_auth_and_user(user:, password:)
    end

    private

    def check_auth_and_user(user:, password:)
      if user && user.authenticate(password)
        return Success(JwtLib.token_encode(user))
      end

      Failure(:not_found)
    end
  end
end
