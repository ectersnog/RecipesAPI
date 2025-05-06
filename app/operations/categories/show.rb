# frozen_string_literal: true

module Categories
  class Show < ApplicationOperation
    def initialize(category:)
      @category = category
    end

    def call
      @category
    end
  end
end
