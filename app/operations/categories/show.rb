# frozen_string_literal: true

module Categories
  class Show < ApplicationOperation
    def initialize(params:)
      @id = params[:id]
    end

    def call
      Category.find(@id)
    end
  end
end
