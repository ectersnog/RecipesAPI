# frozen_string_literal: true

FactoryBot.define do
  factory :recipe do
    name { FFaker::Lorem.sentence(4) }
    user
    description { FFaker::Lorem.sentence(20) }
    is_gluten_free { FFaker::Boolean.maybe }
    is_carb_free { FFaker::Boolean.maybe }
    is_kosher { FFaker::Boolean.maybe }
    is_paleo { FFaker::Boolean.maybe }
    is_vegetarian { FFaker::Boolean.maybe }
    is_vegan { FFaker::Boolean.maybe }
  end
end
