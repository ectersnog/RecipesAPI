# frozen_string_literal: true

module Users
  class Show < ApplicationOperation
    def call(params:)
      id = params[:id]
      step find_user(id)
    end

    private

    def find_user(id)
      user = User.find_by(id:)
      if user
        Success(user)
      else
        Failure(:not_found)
      end
    end
  end
end
