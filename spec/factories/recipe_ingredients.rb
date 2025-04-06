# frozen_string_literal: true

FactoryBot.define do
  factory :recipe_ingredient do
    recipe
    ingredient
    amount { FFaker::Number.decimal }
    unit { Units.all.sample }
    input { "#{amount} #{unit} #{FFaker::Lorem.word}" }
  end
end
