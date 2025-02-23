# frozen_string_literal: true

class RecipeIngredient < ApplicationRecord
  belongs_to :recipe
  belongs_to :ingredient

  enum :unit, {
    cup: 'cup',
    fluid_ounce: 'fluid_ounce',
    gallon: 'gallon',
    gram: 'gram',
    kilogram: 'kilogram',
    liter: 'liter',
    milliliter: 'milliliter',
    ounce: 'ounce',
    pint: 'pint',
    pound: 'pound',
    quart: 'quart',
    tablespoon: 'tablespoon',
    teaspoon: 'teaspoon'
  }

  validates :recipe,
    uniqueness: { scope: :ingredient_id }
  validates :amount,
    numericality: { greater_than: 0 }
end
