# frozen_string_literal: true

module Recipes
  class Create
    def initialize(user, params:)
      @ingredients = params.delete(:ingredients)
      @params = params
      @user = user
    end

    def self.call(user, params: {})
      new(user, params:).call
    end

    def call
      @user.recipes.create(@params) do |obj|
        obj.recipe_ingredients = @ingredients.map do |ingredient|
          # IngredientParser.from_string(ingredient)
          RecipeIngredient.new(user_input: ingredient)
        end
      end
    end
  end
end
