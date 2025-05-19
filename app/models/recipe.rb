# frozen_string_literal: true

class Recipe < ApplicationRecord
  extend FriendlyId

  friendly_id :name, use: :slugged

  belongs_to :user
  has_many :recipe_categories,
    dependent: :destroy
  has_many :categories,
    through: :recipe_categories
  has_many :recipe_ingredients,
    dependent: :destroy
  has_many :ingredients,
    through: :recipe_ingredients
  has_many :recipe_images,
    dependent: :destroy

  validates :name,
    length: { maximum: 100 },
    presence: true
  validates :is_gluten_free, :is_carb_free, :is_kosher,
    :is_paleo, :is_vegetarian, :is_vegan,
    inclusion: { in: [true, false] }
end
