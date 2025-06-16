# frozen_string_literal: true

module Categories
  class Show < ApplicationOperation
    # Gets a specific category object from the database
    #
    # @param params [Hash]
    # @option params [String] :id The UUID of the category to have returned
    #
    # @return [Category] Category object
    def call(params:)
      step find_category(params[:id])
    end

    private

    def find_category(id)
      category = Category.find_by(id:)
      return Failure(:not_found) if category.nil?

      Success(category)
    end
  end
end
