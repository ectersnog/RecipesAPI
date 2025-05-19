# frozen_string_literal: true

FactoryBot.define do
  factory :recipe_ingredient do
    recipe factory: :recipe
    ingredient factory: :ingredient
    amount { FFaker::Number.decimal }
    unit { Units.all.sample }
    input { "#{amount} #{unit.to_s.humanize} of #{ingredient.name}" }
  end
end
