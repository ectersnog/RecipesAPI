# frozen_string_literal: true

module Recipes
  class Create < ApplicationOperation
    def call(current_user:, params:)
      ingredients = params.delete(:ingredients)
      recipe = step create_recipe(current_user:, params:)
      step create_recipe_ingredients(recipe:, ingredients:)
    end

    private

    def create_recipe(current_user:, params:)
      recipe = current_user.recipes.create(params)
      return Failure(:recipe_creation) unless recipe

      Success(recipe)
    end

    def create_recipe_ingredients(recipe:, ingredients:)
      ingredients.map do |ingredient|
        recipe_ingredient = RecipeIngredient.new(recipe:, input: ingredient)
        return Failure(:recipe_ingredient_create) unless recipe_ingredient.save
      end
      Success(recipe)
    end
  end
end
