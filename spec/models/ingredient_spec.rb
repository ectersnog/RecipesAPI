# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Ingredient do
  describe 'validations' do
    it { is_expected.to allow_value("Cheese").for(:name) }
    it { is_expected.not_to allow_value(nil).for(:name) }
  end

  describe '#slug' do
    it 'generates a slug' do
      instance = create(:ingredient)
      expect(instance.slug).to be_present
    end
  end
end
