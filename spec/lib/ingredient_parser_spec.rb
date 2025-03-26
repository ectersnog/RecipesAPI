# frozen_string_literal: true

require 'rails_helper'

RSpec.describe IngredientParser do
  describe '.from_string' do
    it 'returns a RecipeIngredient' do
      instance = described_class.from_string("1/4 cup ground beef")
      expect(instance).to be_a(RecipeIngredient)
      expect(instance.amount).to eq(0.25)
      expect(instance.unit).to eq('cup')
      expect(instance.ingredient.name).to eq('ground beef')
    end

    it 'creates a new Ingredient' do
      instance = described_class.from_string("3 cups of milk")
      expect(instance.ingredient).to be_a(Ingredient)
      expect(instance.ingredient.name).to eq('milk')
    end

    it 'finds an existing Ingredient' do
      ingredient = Ingredient.create(name: "carrots")
      instance = described_class.from_string("1 lb of carrots")
      expect(instance.ingredient_id).to eq(ingredient.id)
    end

    it 'raises custom error if it fails to parse' do
      expect { described_class.from_string "a" }.to raise_error IngredientParser::Error
    end
  end
end
