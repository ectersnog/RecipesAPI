# frozen_string_literal: true

module Recipes
  class Index < ApplicationOperation
    # Gets Recipes from Database
    #
    # @param params [Hash]
    # @option params [Integer] :page The page of results to return
    # @option params [Integer] :per_page The number of elements to return on the page
    #
    # @return [Dry::Monads::Result::Success<ActiveRecord::Relation<Recipe>>]
    def call(params:)
      step get_recipes(params:)
    end

    private

    def get_recipes(params:)
      recipes = RecipeQuery.new.paginate(params[:page], params[:per_page])
      Success(recipes)
    end
  end
end
