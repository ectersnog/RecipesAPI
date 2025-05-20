# frozen_string_literal: true

module Users
  class Update < ApplicationOperation
    def initialize(current_user: , params:)
      @current_user = current_user
      @params = params
    end

    def call
      @current_user.update!(@params)
    end
  end
end
