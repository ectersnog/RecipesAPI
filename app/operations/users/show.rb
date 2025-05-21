# frozen_string_literal: true

module Users
  class Show < ApplicationOperation
    def initialize(current_user:, params:)
      @current_user = current_user
      @params = params
    end

    def call
      User.find_by(id: @params[:id])
    end
  end
end
