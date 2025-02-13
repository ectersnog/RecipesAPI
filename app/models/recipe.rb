# frozen_string_literal: true

class Recipe < ApplicationRecord
  extend FriendlyId

  friendly_id :name, use: :slugged

  validates :name,
    presence: true
  validates :is_gluten_free, inclusion: { in: [true, false] }
  validates :is_carb_free, inclusion: { in: [true, false] }
  validates :is_kosher, inclusion: { in: [true, false] }
  validates :is_paleo, inclusion: { in: [true, false] }
  validates :is_vegetarian, inclusion: { in: [true, false] }
  validates :is_vegan, inclusion: { in: [true, false] }
end
