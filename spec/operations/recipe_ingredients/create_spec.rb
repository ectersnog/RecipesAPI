# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RecipeIngredient do
  describe '#parsing' do
    let(:recipe) do
      create(:recipe,
        name: 'mac and cheese',
        id: '0a485d75-360e-4e05-bc47-0afced3d8090'
      )
    end

    it 'is able to add recipe_ingredients' do
      result = described_class.new(recipe:, input: '1lb of cheese')
      expect(result).to be_valid
      expect(result.errors).to be_empty
    end

    it 'should fail if input is invalid' do
      result = described_class.new(recipe: recipe, input: 'aaaaa of aaaa')
      expect(result).not_to be_valid
    end
  end
end
