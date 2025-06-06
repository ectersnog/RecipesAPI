# frozen_string_literal: true

module Users
  class Update < ApplicationOperation
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
