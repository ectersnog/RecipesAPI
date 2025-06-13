# frozen_string_literal: true

module Users
  class Update < ApplicationOperation
    # Updates a current user information
    #
    # @param current_user [User] currently logged-in user
    # @param params [Hash] includes all user properties
    # @option params [String] :name Name to update user to
    # @option params [String] :email Email address to update user to
    # @option params [String] :password Password to update user to
    #
    # @return [User, Error] Updated user object on success, errors on failure
    def call(current_user:, params:)
      step update_user(current_user:, params:)
    end

    private

    def update_user(current_user:, params:)
      if current_user.update(params)
        Success(current_user)
      else
        Failure(current_user.errors)
      end
    end
  end
end
