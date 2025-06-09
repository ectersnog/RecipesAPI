# frozen_string_literal: true

module Users
  class Create < ApplicationOperation
    def call(params:)
      step create_user(params:)
    end

    private

    def create_user(params:)
      user = User.new(name: params[:name], email: params[:email], password: params[:password])
      if user.save
        Success(user)
      else
        Failure(user.errors.full_messages)
      end
    end
  end
end
