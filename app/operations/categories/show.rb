# frozen_string_literal: true

module Categories
  class Show < ApplicationOperation
    def call(params:)
      id = params[:id]
      step find_category(id)
    end

    private

    def find_category(id)
      category = Category.find_by(id:)
      return Failure(:not_found) unless category

      Success(category)
    end
  end
end
