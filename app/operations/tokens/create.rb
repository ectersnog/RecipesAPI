# frozen_string_literal: true

module Tokens
  class Create < ApplicationOperation
    # Creates an authorization token
    #
    # @param params [Hash]
    # @option params [String] :email Email address to log in with
    # @option params [String] :password Password to log in with
    #
    # @return [Dry::Monads::Result::Success<JWT>, Dry::Monads::Result::Failure]
    def call(params:)
      user = step get_user(params:)
      step check_auth_and_user(user:, password: params[:password])
    end

    private

    def get_user(params:)
      user = User.find_by(email: params[:email])
      Success(user)
    end

    def check_auth_and_user(user:, password:)
      if user && user.authenticate(password)
        Success(JwtLib.token_encode(user))
      else
        Failure(:not_found)
      end
    end
  end
end
