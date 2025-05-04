# frozen_string_literal: true

module V1
  class RecipesController < ApplicationController
    def index
      recipes = Recipes::Index.call(params:)
      render locals: { recipes: }
    end

    def show
      recipe = Recipes::Show.call(params:)
      render locals: { recipe: }
    end
  end
end
