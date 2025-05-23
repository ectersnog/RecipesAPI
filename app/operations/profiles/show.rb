# frozen_string_literal: true

module Profiles
  class Show < ApplicationOperation
    def initialize(user:)
      @user = user
    end

    def call
      @user
    end
  end
end
