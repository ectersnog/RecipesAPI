# frozen_string_literal: true

module Categories
  class Index < ApplicationOperation
    # Gets Categories from Database
    #
    # @param params [Hash]
    # @option params [Integer] :page The page of results to return
    # @option params [Integer] :per_page The number of elements to return on the page
    #
    # @return [Array<Category>] an array of categories
    def call(params:)
      page = params[:page] ||= 1
      per_page = params[:per_page] ||= 10

      step get_index(page, per_page)
    end

    private

    def get_index(page, per_page)
      categories = Category.order(:name).page(page).per(per_page)

      Success(categories)
    end
  end
end
