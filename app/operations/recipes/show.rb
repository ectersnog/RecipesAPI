# frozen_string_literal: true

module Recipes
  class Show < ApplicationOperation
    def call(params:)
      id = params[:id]
      step find_recipe(id)
    end

    private

    def find_recipe(id)
      recipe = Recipe.find_by(id:)
      return Failure(:not_found) unless recipe

      Success(recipe)
    end
  end
end
