# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Recipes::Index do
  describe '#call' do
    let!(:rec_a) { create(:recipe, name: 'Nachos') }
    let!(:rec_b) { create(:recipe, name: 'Pasta') }
    let!(:rec_c) { create(:recipe, name: 'Pizza') }

    it 'returns specific page of results' do
      result = described_class.call(params: { page: 1, per_page: 2 })
      expect(result.success.length).to eq(2)
      expect(result.success).to include(rec_a, rec_b)

      result = described_class.call(params: { page: 2, per_page: 2 })
      expect(result.success.first.id).to eq(rec_c.id)
    end
  end
end
