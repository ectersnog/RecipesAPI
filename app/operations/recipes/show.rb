# frozen_string_literal: true

module Recipes
  class Show
    def initialize(params:)
      @id = params[:id]
    end

    def self.call(params: {})
      new(params:).call
    end

    def call
      Recipe.find(@id)
    end
  end
end
