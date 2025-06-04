# frozen_string_literal: true

module Profiles
  class Show < ApplicationOperation
    def call(user:)
      Success(user)
    end
  end
end
