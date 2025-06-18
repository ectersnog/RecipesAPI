# frozen_string_literal: true

module Users
  class Create < ApplicationOperation
    # Creates a new user
    #
    # @param params [Hash]
    # @option params [String] :name Name of the user
    # @option params [String] :email Email address for user
    # @option params [String] :password Password for user
    #
    # @return [Dry::Monads::Result::Success<User>, Dry::Monads::Result::Failure]
    def call(params:)
      step create_user(params:)
    end

    private

    def create_user(params:)
      user = User.new(name: params[:name], email: params[:email], password: params[:password])
      return Success(user) if user.save

      Failure(user.errors.full_messages)
    end
  end
end
