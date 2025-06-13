# frozen_string_literal: true

module Recipes
  class Show < ApplicationOperation
    # Gets a specific recipe from the database
    #
    # @param params [Hash]
    # @option params [String] :id The UUID of the recipe to return
    #
    # @return [Recipe] Recipe object
    def call(params:)
      step find_recipe(params:)
    end

    private

    def find_recipe(params:)
      Success(Recipe.find(params[:id]))
    end
  end
end
