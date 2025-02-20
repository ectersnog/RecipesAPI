# frozen_string_literal: true

FactoryBot.define do
  factory :recipe_category do
    recipe
    category
  end
end
