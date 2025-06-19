# frozen_string_literal: true

module V1
  class CategoriesController < ApplicationController
    def index
      result = Categories::Index.call(params:)
      if result.success?
        render locals: { categories: result.success }
      else
        render json: { errors: result.failure }, status: :not_found
      end
    end

    def show
      result = Categories::Show.call(params:)
      if result.success?
        render locals: { category: result.success }
      else
        render json: { errors: result.failure }, status: :not_found
      end
    end
  end
end
