# frozen_string_literal: true

FactoryBot.define do
  factory :recipe_step do
    recipe
    position { FFaker::Number.between(from: 1, to: 5) }
    description { FFaker::Lorem.sentence }
    image { Rails.root.join("spec/media/image.jpg").open }
  end
end
