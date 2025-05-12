# frozen_string_literal: true

module Users
  class Create < ApplicationOperation
    def initialize(params:)
      @params = params
    end

    def call
      return nil if User.find_by(email: @params[:email])

      user = User.new(name: @params[:name], email: @params[:email], password: @params[:password])
      return nil unless user.save

      payload = {
        user_id: user.id,
        exp: 7.days.from_now.to_i
      }
      JWT.encode(payload, ENV.fetch('JWT_SECRET_KEY'), 'HS256')
    end
  end
end
