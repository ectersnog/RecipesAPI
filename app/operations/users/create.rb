# frozen_string_literal: true

module Users
  class Create < ApplicationOperation
    def initialize(params:)
      @params = params
    end

    def call
      # return nil if User.find_by(email: @params[:email])

      user = User.new(
        name: @params[:name],
        email: @params[:email],
        password: @params[:password]
      )
      user.save
      user
    end
  end
end
