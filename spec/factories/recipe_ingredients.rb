# frozen_string_literal: true

FactoryBot.define do
  factory :recipe_ingredient do
    recipe factory: :recipe
    ingredient factory: :ingredient
    amount { FFaker::Number.decimal }
    unit { Units.all.sample }
    after(:build) do |recipe_ingredient|
      recipe_ingredient.input ||= "#{recipe_ingredient.amount} #{recipe_ingredient.unit.to_s.sub('_', ' ')} of #{recipe_ingredient.ingredient.name}"
    end

    # input { "#{amount} #{unit.to_s.sub('_', ' ')} of #{ingredient.name}" }
  end
end
