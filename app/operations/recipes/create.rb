# frozen_string_literal: true

module Recipes
  class Create
    def self.call(user, params:)
      ingredients = params.delete(:ingredients)
      recipe_name = params.delete(:name)
      recipe = build_recipe(recipe_name, user, params:)
      build_recipe_ingredients(recipe, ingredients)
      diet_types(recipe, params:)
      recipe.save!
      recipe
    end

    def self.build_recipe_ingredients(recipe, ingredients)
      ingredients.each do |ingredient|
        recipe.recipe_ingredients << IngredientParser.from_string(ingredient)
      end
    end

    def self.build_recipe(name, user, params:)
      Recipe.new(name:,
        user_id: user.id,
        steps: params.delete(:steps),
        description: params.delete(:description),
        nutritional_info: params.delete(:nutritional_info)
      )
    end

    def self.diet_types(recipe, params:)
      recipe.is_gluten_free = params.delete(:is_gluten_free) if params.key?(:is_gluten_free)
      recipe.is_carb_free = params.delete(:is_carb_free) if params.key?(:is_carb_free)
      recipe.is_kosher = params.delete(:is_kosher) if params.key?(:is_kosher)
      recipe.is_paleo = params.delete(:is_paleo) if params.key?(:is_paleo)
      recipe.is_vegan = params.delete(:is_vegan) if params.key?(:is_vegan)
      recipe.is_vegetarian = params.delete(:is_vegetarian) if params.key?(:is_vegetarian)
    end
  end
end

