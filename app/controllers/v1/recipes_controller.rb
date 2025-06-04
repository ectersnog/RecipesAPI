# frozen_string_literal: true

module V1
  class RecipesController < ApplicationController
    def index
      result = Recipes::Index.call(params:)
      if result.success?
        render locals: { recipes: result.success }
      elsif result.failure?
        render json: { errors: result.failure }
      end
    end

    def show
      result = Recipes::Show.call(params:)
      if result.success?
        render locals: { recipe: result.success }
      elsif result.failure?
        render json: { errors: result.failure }, status: :not_found
      end
    end
  end
end
