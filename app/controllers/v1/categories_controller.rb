# frozen_string_literal: true

module V1
  class CategoriesController < ApplicationController
    def index
      categories = Categories::Index.call(params:)
      render locals: { categories: }
    end

    def show
      category = Categories::Show.call(
        category: Category.find(params[:id])
      )
      render locals: { category: }
    end
  end
end
