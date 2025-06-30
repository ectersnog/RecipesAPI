# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RecipeQueryAdvanced do
  describe '#call' do
    let(:boolean_filters) do
      {
        is_carb_free: false,
        is_kosher: false,
        is_paleo: false,
        is_gluten_free: false,
        is_vegetarian: false,
        is_vegan: false
      }
    end

    let!(:carb_free) { create(:recipe, { **boolean_filters, is_carb_free: true }) }
    let!(:kosher) { create(:recipe, { **boolean_filters, is_kosher: true }) }
    let!(:paleo) { create(:recipe, { **boolean_filters, is_paleo: true }) }
    let!(:gluten_free) { create(:recipe, { **boolean_filters, is_gluten_free: true }) }
    let!(:vegetarian) { create(:recipe, { **boolean_filters, is_vegetarian: true }) }
    let!(:vegan) { create(:recipe, { **boolean_filters, is_vegan: true }) }

    it 'returns all recipes when no filters are applied' do
      result = described_class.call
      expect(result.count).to eq(6)
    end

    it 'filters by carb free' do
      result = described_class.call({ is_carb_free: true })
      expect(result.first).to eq(carb_free)
      expect(result.first.is_carb_free).to be(true)
    end

    it 'filters by kosher' do
      result = described_class.call({ is_kosher: true })
      expect(result.first).to eq(kosher)
      expect(result.first.is_kosher).to be(true)
    end

    it 'filters by pale' do
      result = described_class.call({ is_paleo: true })
      expect(result.first).to eq(paleo)
      expect(result.first.is_paleo).to be(true)
    end

    it 'filters by gluten-free' do
      result = described_class.call({ is_gluten_free: true })
      expect(result.first).to eq(gluten_free)
      expect(result.first.is_gluten_free).to be(true)
    end

    it 'filters by vegetarian' do
      result = described_class.call({ is_vegetarian: true })
      expect(result.first).to eq(vegetarian)
      expect(result.first.is_vegetarian).to be(true)
    end

    it 'filters by vegan' do
      result = described_class.call({ is_vegan: true })
      expect(result.first).to eq(vegan)
      expect(result.first.is_vegan).to be(true)
    end

    it 'filters by boolean values and search term' do
      result = described_class.call({ is_vegan: true, q: vegan.name })
      expect(result.count).to eq(1)
      expect(result.first).to eq(vegan)
    end

    it 'searches by provided query' do
      result = described_class.call({ q: vegetarian.name })
      expect(result.count).to eq(1)
      expect(result.first).to eq(vegetarian)
    end

    it 'returns an empty array when no recipes match the filters' do
      result = described_class.call({ q: 'Nonexistent Recipe' })
      expect(result.count).to eq(0)
    end

    it 'returns paginated results' do
      result = described_class.call({ page: 1, per_page: 3 })
      expect(result.count).to eq(3)
    end
  end
end
