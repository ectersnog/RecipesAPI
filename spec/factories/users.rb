# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { FFaker::Name.name }
    email { FFaker::Internet.email }
    password { "testing" }
    password_confirmation { "testing" }
    slug { FriendlyIdGenerator }
  end
end
