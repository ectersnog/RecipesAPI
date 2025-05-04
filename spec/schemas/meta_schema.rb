# frozen_string_literal: true

module Schemas
  module Meta
    def self.schema
      {
        meta: {
          type: :object,
          properties: {
            current_page: { type: :integer },
            total_pages: { type: :integer },
            records: { type: :integer },
            total_records: { type: :integer }
          },
          required: %w[current_page total_pages records total_records]
        }
      }
    end
  end
end
