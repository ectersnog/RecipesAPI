# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Ingredient, type: do
  describe 'validations' do
    it { is_expected.to allow_value("cheese").for(:name) }
    it { is_expected.not_to allow_value(nil).for(:name) }
  end
end
