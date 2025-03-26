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

    it 'raises custom error if it fails to parse' do
      expect { described_class.from_string "asdf asdf asdf" }.to raise_error IngredientParser::Error, "unable to parse ingredient"
    end
  end
end
