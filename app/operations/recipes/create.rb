# frozen_string_literal: true

module Recipes
  class Create < ApplicationOperation
    def call(user, params:)
      ingredients = params.delete(:ingredients)
      user.recipes.create(params) do |obj|
        obj.recipe_ingredients = ingredients.map do |ingredient|
          RecipeIngredient.new(input: ingredient)
        end
      end
    end
  end
end
