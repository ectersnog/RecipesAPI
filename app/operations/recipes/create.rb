# frozen_string_literal: true

module Recipes
  class Create < ApplicationOperation
    # Creates a recipe, along with RecipeIngredients
    #
    # @param current_user [User] Currently logged-in user to associate recipe to
    # @param params [Hash]
    # @option params [String] :name The name of the recipe
    # @option params [String] :description A description of the recipe
    # @option params [Image] :cover_photo An image for the recipe
    # @option params [Array<RecipeStep>] An array of Recipe Step objects for the recipe
    # @option params [Boolean] :is_gluten_free Is the recipe gluten-free
    # @option params [Boolean] :is_carb_free Is the recipe carb free
    # @option params [Boolean] :is_kosher Is the recipe kosher
    # @option params [Boolean] :is_paleo Is the recipe paleo
    # @option params [Boolean] :is_vegetarian Is the recipe vegetarian
    # @option params [Boolean] :is_vegan Is the recipe vegan
    #
    # @return [Dry::Monads::Result::Success<Recipe>]
    # @see Recipe
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
      ingredients.each do |ingredient|
        recipe_ingredient = RecipeIngredient.new(recipe:, input: ingredient)
        return Failure(:recipe_ingredient_create) unless recipe_ingredient.save
      end
      Success(recipe)
    end
  end
end
