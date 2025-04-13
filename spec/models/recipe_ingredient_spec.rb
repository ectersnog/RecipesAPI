# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RecipeIngredient do
  let(:recipe_ingredient) { create(:recipe_ingredient) }

  it "has a valid factory" do
    instance = create(:recipe_ingredient)
    expect(instance).to be_valid
  end

  # it { expect(recipe_ingredient).to belong_to(:recipe) }

  describe "associations" do
    it { is_expected.to belong_to(:recipe) }
    it { is_expected.to belong_to(:ingredient) }
  end
end
