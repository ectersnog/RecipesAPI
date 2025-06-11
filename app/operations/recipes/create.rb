# frozen_string_literal: true

module Recipes
  class Create < ApplicationOperation
    def call(current_user:, params:)
      ingredients = params.delete(:ingredients)
      steps = params.delete(:steps)
      recipe = step create_recipe(current_user:, params:)
      step create_recipe_ingredients(recipe:, ingredients:)
      step create_recipe_steps(recipe:, steps:)
    end

    private

    def create_recipe(current_user:, params:)
      recipe = current_user.recipes.create(params)
      return Failure(:recipe_creation) unless recipe

      Success(recipe)
    end

    def create_recipe_ingredients(recipe:, ingredients:)
      ingredients.each do |ingredient|
        recipe_ingredient = RecipeIngredient.new(recipe:, input: ingredient)
        return Failure(:recipe_ingredient_create) unless recipe_ingredient.save
      end
      Success(recipe)
    end

    def create_recipe_steps(recipe:, steps:)
      steps.each do |step|
        recipe_step = RecipeStep.new(recipe:, description: step)
        return Failure(:recipe_step_creation) unless recipe_step.save
      end
      Success(recipe)
    end
  end
end
