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

    def create
      result = Recipes::Create.call(
        current_user:,
        params: create_params
      )
      if result.success?
        render 'show', locals: { recipe: result.success }
      elsif result.failure?
        render json: { errors: result.failure }, status: :unprocessable_entity
      end
    end

    private

    def create_params
      params.expect(data: [
        :name,
        :nutritional_info,
        :description,
        { ingredients: [] },
        { steps: [] },
        :is_gluten_free,
        :is_carb_free,
        :is_kosher,
        :is_paleo,
        :is_vegetarian,
        :is_vegan
      ])
    end
  end
end
