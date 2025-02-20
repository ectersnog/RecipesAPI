# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Category do
  describe 'validations' do
    it { is_expected.to allow_value("Italian").for(:name) }
    it { is_expected.not_to allow_value(nil).for(:name) }
  end

  describe 'RecipeCategory associations' do
    it 'can access category recipe' do
      category = create(:category)
      category.recipes << create(:recipe)
      expect(category.recipes).to be_present
    end
  end

  describe '#slug' do
    it 'generates a slug' do
      instance = create(:category)
      expect(instance.slug).to be_present
    end
  end
end
