# frozen_string_literal: true

FactoryBot.define do
  factory :ingredient do
    name { FFaker::Lorem.word }
  end
end
