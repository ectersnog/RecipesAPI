# frozen_string_literal: true

module V1
  class RecipesController < ApplicationController
    def index
      recipes = Recipes::Index.call(params:)
      render locals: { recipes: }
    end
  end
end
