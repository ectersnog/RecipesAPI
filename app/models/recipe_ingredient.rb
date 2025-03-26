# frozen_string_literal: true

class RecipeIngredient < ApplicationRecord
  belongs_to :recipe
  belongs_to :ingredient

  validates :recipe,
    uniqueness: { scope: :ingredient_id }
  validates :amount,
    numericality: { greater_than: 0 }
  validates :unit,
    inclusion: { in: Units.all.to_s }
end
