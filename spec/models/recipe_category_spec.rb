# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RecipeCategory do
  it "has a valid factory" do
    expect(create(:recipe_category)).to be_valid
  end

  it "belongs to a recipe and a category" do
    recipe_category = create(:recipe_category)
    expect(recipe_category.recipe).to be_a(Recipe)
    expect(recipe_category.category).to be_a(Category)
  end
end
