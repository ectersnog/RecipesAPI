# frozen_string_literal: true

module V1
  class CategoriesController < ApplicationController
    def index
      # @categories = Category.all
      @categories = Categories::Index.call(params:)
    end

    def show
      render json: Categories::Show.call(params:)
    end
  end
end
