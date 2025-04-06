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
          RecipeIngredient.new(user_input: ingredient)
        end
        unless obj.valid?
          obj.recipe_ingredients.each_with_index do |ingredient, index|
            next if ingredient.errors.empty?

            ingredient.errors.full_messages.each do |message|
              obj.errors.add(:recipe_ingredients, message: "RecipeIngredient #{index + 1}: #{message}")
            end
          end
          return obj
        end
        obj.save
        obj
      end
    end
  end
end
