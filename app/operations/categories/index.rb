# frozen_string_literal: true

module Categories
  class Index < ApplicationOperation
    # Gets Categories from Database
    #
    # @param params [Hash]
    # @option params [Integer] :page The page of results to return
    # @option params [Integer] :per_page The number of elements to return on the page
    # @return [Dry::Monad::Result::Success<ActiveRecord::Relation<Category>>]
    def call(params:)
      step get_index(params:)
    end

    private

    def get_index(params:)
      categories = Category.order(:name)
        .page(params[:page])
        .per(params[:per_page])

      Success(categories)
    end
  end
end
