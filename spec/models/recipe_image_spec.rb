# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RecipeImage do
  it "has a valid factory" do
    instance = create(:recipe_image)
    expect(instance).to be_valid
  end

  describe "associations" do
    it { is_expected.to belong_to(:recipe) }
  end
end
