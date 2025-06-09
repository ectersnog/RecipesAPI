# frozen_string_literal: true

module Recipes
  class Index < ApplicationOperation
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
