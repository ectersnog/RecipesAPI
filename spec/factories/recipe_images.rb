# frozen_string_literal: true

require_relative '../support/image_testdata'

FactoryBot.define do
  factory :recipe_image do
    recipe
    image { Rails.root.join("spec/media/image.jpg").open }
  end
end
