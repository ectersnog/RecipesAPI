# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Categories::Index do
  describe '#call' do
    let!(:cat_a) { create(:category, name: 'American') }
    let!(:cat_b) { create(:category, name: 'Italian') }
    let!(:cat_c) { create(:category, name: 'Mexican') }

    it 'returns specific page of results' do
      result = described_class.call(params: { page: 1, limit_value: 2 })
      expect(result.length).to eq(2)
      expect(result).to include(cat_a, cat_b)

      result = described_class.call(params: { page: 2, limit_value: 2 })
      expect(result.first.name).to eq(cat_c.name)
    end
  end
end
