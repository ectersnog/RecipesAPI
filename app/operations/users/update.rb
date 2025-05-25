# frozen_string_literal: true

module Users
  class Update < ApplicationOperation
    def initialize(current_user:, params:)
      @current_user = current_user
      @params = params
    end

    def call
      step update_user
    end

    private

    def update_user
      if @current_user.update!(@params)
        Success(@current_user)
      else
        Failure(:unprocessable_entity)
      end
    end
  end
end
