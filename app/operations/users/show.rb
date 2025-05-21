# frozen_string_literal: true

module Users
  class Show < ApplicationOperation
    def initialize(current_user:, params:)
      @current_user = current_user
      @params = params
    end

    def call

    end
  end
end
