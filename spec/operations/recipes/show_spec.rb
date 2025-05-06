# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Recipes::Show do
  describe '#call' do
    let(:recipe_a) do
      create(:recipe,
      name: 'Pizza',
      id: '0a485d75-360e-4e05-bc47-0afced3d8090')
    end

    it 'returns a specific record by id' do
      result = described_class.call(recipe: recipe_a)
      expect(result.id).to eq(recipe_a.id)
    end
  end
end
