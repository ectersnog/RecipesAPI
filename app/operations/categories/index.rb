# frozen_string_literal: true

module Categories
  class Index
    def initialize(params:)
      @current_page = params[:page]
      @limit_value = params[:limit_value]
    end

    def self.call(params: {})
      new(params:).call
    end

    def call
      Category.order(:name).page(@current_page).per(@limit_value)
    end
  end
end
