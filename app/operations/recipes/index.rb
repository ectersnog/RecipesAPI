# frozen_string_literal: true

module Recipes
  class Index < ApplicationOperation
    def initialize(params:)
      @page = params[:page] ||= 1
      @per_page = params[:per_page] ||= 10
    end

    def call
      RecipeQuery.new.paginate(page: @page, per_page: @per_page)
    end
  end
end
