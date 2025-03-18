# frozen_string_literal: true

FactoryBot.define do
  factory :recipe_image do
    recipe
    image { Rails.root.join("spec/media/image.jpg").open }
  end
end
