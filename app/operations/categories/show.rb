# frozen_string_literal: true

module Categories
  class Show
    def initialize(params:)
      @id = params[:id]
    end

    def self.call(params: {})
      new(params:).call
    end

    def call
      Category.find(@id)
    end
  end
end
