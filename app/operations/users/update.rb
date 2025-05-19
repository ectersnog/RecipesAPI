# frozen_string_literal: true

module Users
  class Update < ApplicationOperation
    def initialize(params:)
      @params = params
    end

    def call
      user = User.find_by(email: @params[:email])
      return unless user

      user.update(email: @params[:email], password: @params[:password])
    end
  end
end
