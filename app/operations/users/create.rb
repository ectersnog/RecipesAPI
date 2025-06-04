# frozen_string_literal: true

module Users
  class Create < ApplicationOperation
    def call(params:)
      name = params[:name]
      email = params[:email]
      password = params[:password]

      step create_user(name, email, password)
    end

    private

    def create_user(name, email, password)
      user = User.new(name:, email:, password:)
      if user.save
        Success(user)
      else
        Failure(user.errors.full_messages)
      end
    end
  end
end
