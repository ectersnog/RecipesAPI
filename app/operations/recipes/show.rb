# frozen_string_literal: true

module Recipes
  class Show < ApplicationOperation
    def initialize(recipe:)
      @recipe = recipe
    end

    def call
      @recipe
    end
  end
end
