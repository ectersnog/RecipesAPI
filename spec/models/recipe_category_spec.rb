# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RecipeCategory do
  it "has a valid factory" do
    expect(create(:recipe_category)).to be_valid
  end

  describe 'associations' do
    it { is_expected.to belong_to(:recipe) }
    it { is_expected.to belong_to(:category) }
  end
end
