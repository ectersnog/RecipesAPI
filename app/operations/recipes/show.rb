# frozen_string_literal: true

module Recipes
  class Show < ApplicationOperation
    def initialize(params:)
      @id = params[:id]
    end

    def call
      Recipe.find(@id)
    end
  end
end
