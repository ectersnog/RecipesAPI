# frozen_string_literal: true

module Recipes
  class Show < ApplicationOperation
    def call(params:)
      step find_recipe(params:)
    end

    private

    def find_recipe(params:)
      Success(Recipe.find(params[:id]))
    end
  end
end
