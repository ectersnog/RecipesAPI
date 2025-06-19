# frozen_string_literal: true

module Users
  class Show < ApplicationOperation
    # Get a User record from the database
    #
    # @param params [Hash]
    # @option params [String] :id The UUID of the user to return
    # @raise ActiveRecord::RecordNotFound
    # @return [Dry::Monads::Result::Success<User>]
    #
    def call(params:)
      step find_user(params:)
    end

    private

    def find_user(params:)
      Success(User.find(params[:id]))
    end
  end
end
