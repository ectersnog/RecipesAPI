# frozen_string_literal: true

module Users
  class Create < ApplicationOperation
    def initialize(params:)
      @params = params
    end

    def call
      user = step build_user
      step save_user(user)
    end

    private

    def build_user
      user = User.new(
        name: @params[:name],
        email: @params[:email],
        password: @params[:password]
      )
      Success(user)
    end

    def save_user(user)
      if user.save
        Success(user)
      else
        Failure(user.errors.full_messages)
      end
    end
  end
end
