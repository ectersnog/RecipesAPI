# frozen_string_literal: true

module Sessions
  class Create < ApplicationOperation

    def initialize(params:)
      @params = params
    end

    def call
      user = User.find_by(email: @params[:email])
      return nil unless user && user.authenticate(@params[:password])

      payload = {
        user_id: user.id,
        exp: 7.days.from_now.to_i
      }
      JWT.encode(payload, ENV.fetch('JWT_SECRET_KEY'), 'HS256')
    end
  end
end
