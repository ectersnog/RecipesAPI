# frozen_string_literal: true

class Recipe < ApplicationRecord
  extend FriendlyId

  friendly_id :name, use: :slugged

  has_many :recipe_categories,
    dependent: :destroy
  has_many :categories,
    through: :recipe_categories

  validates :name,
    length: { maximum: 100 },
    presence: true
  validates :is_gluten_free, :is_carb_free, :is_kosher,
    :is_paleo, :is_vegetarian, :is_vegan,
    inclusion: { in: [true, false] }
end
