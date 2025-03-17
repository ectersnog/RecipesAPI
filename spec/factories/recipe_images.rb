# frozen_string_literal: true

FactoryBot.define do
  factory :recipe_image do
    recipe
    image_data { TestData.image_data }
  end
end
