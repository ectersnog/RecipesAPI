# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Categories::Show do
  describe '#call' do
    let(:cat_a) do
      create(:category,
      name: 'American',
      id: '0a485d75-360e-4e05-bc47-0afced3d8090')
    end

    it 'returns a specific record by id' do
      result = described_class.call(category: cat_a)
      expect(result.id).to eq(cat_a.id)
    end
  end
end
