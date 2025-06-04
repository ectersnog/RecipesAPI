# frozen_string_literal: true

module Recipes
  class Index < ApplicationOperation
    def call(params:)
      page = params[:page] ||= 1
      per_page = params[:per_page] ||= 10
      step get_recipes(page, per_page)
    end

    private

    def get_recipes(page, per_page)
      recipes = RecipeQuery.new.paginate(page:, per_page:)
      return Failure(:not_found) unless recipes

      Success(recipes)
    end
  end
end
