# frozen_string_literal: true

module Profiles
  class Show < ApplicationOperation
    # Returns the information for current_user
    #
    # @param user [User] User to return profile for
    #
    # @return [Dry::Monads::Result::Success<User>]
    def call(user:)
      step get_profile(user:)
    end

    private

    def get_profile(user:)
      Success(user)
    end
  end
end
