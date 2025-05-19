# frozen_string_literal: true

module Categories
  class Index < ApplicationOperation
    def initialize(params:)
      @page = params[:page].to_i
      @per_page = params[:per_page].to_i unless params[:per_page].nil?
    end

    def call
      Category.order(:name).page(@page).per(@per_page)
    end
  end
end
