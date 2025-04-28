# frozen_string_literal: true

module V1
  class CategoriesController < ApplicationController
    def index
      @categories = Categories::Index.call(params:)
    end

    def show
      @category = Categories::Show.call(params:)
    end
  end
end
