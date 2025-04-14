# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RecipeIngredient do
  it "has a valid factory" do
    instance = build(:recipe_ingredient)
    expect(instance).to be_valid
  end

  describe "associations" do
    it { is_expected.to belong_to(:recipe) }
    it { is_expected.to belong_to(:ingredient).required }
  end
end
