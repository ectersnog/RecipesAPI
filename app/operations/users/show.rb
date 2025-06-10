# frozen_string_literal: true

module Users
  class Show < ApplicationOperation
    def call(params:)
      step find_user(params:)
    end

    private

    def find_user(params:)
      Success(User.find(params[:id]))
    end
  end
end
