# frozen_string_literal: true

module Profiles
  class Show < ApplicationOperation
    def call(user:)
      user
    end
  end
end
