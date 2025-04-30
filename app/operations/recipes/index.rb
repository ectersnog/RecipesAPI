# frozen_string_literal: true

module Recipes
  class Index
    def initialize(params:)
      @page = params[:page].to_i
      @per_page = params[:per_page].to_i
    end

    def self.call(params: {})
      new(params:).call
    end

    def call
      # Recipes.order(:name).page(@page).per(@per_page)
      RecipeQuery.new.paginate(page: @page, per_page: @per_page)
    end
  end
end
