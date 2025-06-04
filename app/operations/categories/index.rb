# frozen_string_literal: true

module Categories
  class Index < ApplicationOperation
    def call(params:)
      page = params[:page] ||= 1
      per_page = params[:per_page] ||= 10

      categories = step get_index(page, per_page)
      categories
    end

    private

    def get_index(page, per_page)
      categories = Category.order(:name).page(page).per(per_page)
      return Failure(:real_problem) unless categories

      Success(categories)
    end
  end
end
