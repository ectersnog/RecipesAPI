# frozen_string_literal: true

module Users
  class Show < ApplicationOperation
    def initialize(current_user:, params:)
      @current_user = current_user
      @params = params
    end

    def call
      step find_user
    end

    private

    def find_user
      user = User.find_by(id: @params[:id])
      if user
        Success(user)
      else
        Failure(:not_found)
      end
    end
  end
end
