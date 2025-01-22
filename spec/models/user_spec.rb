# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User do
  describe 'validations' do
    it { is_expected.to allow_value("John").for(:name) }
    it { is_expected.not_to allow_value(nil).for(:name) }
    it { is_expected.not_to allow_value("A" * 31).for(:name) }
  end

  describe '#slug' do
    it 'generates a slug' do
      instance = create(:user)
      expect(instance.slug).to be_present
    end
  end
end
