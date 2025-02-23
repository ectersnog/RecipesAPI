# frozen_string_literal: true

class Ingredient < ApplicationRecord
  extend FriendlyId

  friendly_id :name, use: :slugged

  has_many :recipe_ingredients,
    dependent: :destroy
  has_many :recipes,
    through: :recipe_ingredients

  validates :name, presence: true
end
