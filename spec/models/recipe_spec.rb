# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Recipe do
  describe 'validations' do
    it { is_expected.to allow_value(FFaker::Lorem.word).for(:name) }
    it { is_expected.not_to allow_value(nil).for(:name) }
  end

  describe 'boolean validations' do
    %i[is_gluten_free is_carb_free is_kosher is_paleo is_vegetarian is_vegan].each do |name|
      it { is_expected.to allow_value(true).for(name) }
      it { is_expected.to allow_value(false).for(name) }
      it { is_expected.not_to allow_value(nil).for(name) }
    end
  end

  describe 'associations' do
    it { is_expected.to have_many(:recipe_categories) }
    it { is_expected.to have_many(:categories).through(:recipe_categories) }
  end

  describe '#slug' do
    it 'generates a slug' do
      recipe = create(:recipe)
      expect(recipe.slug).to be_present
    end
  end
end
