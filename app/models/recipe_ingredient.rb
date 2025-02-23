# frozen_string_literal: true

class RecipeIngredient < ApplicationRecord
  belongs_to :recipe
  belongs_to :ingredient

  enum :unit, {
    tablespoon: 'tablespoon',
    teaspoon: 'teaspoon',
    ounce: 'ounce',
    fluid_ounce: 'fluid_ounce',
    cup: 'cup',
    quart: 'quart',
    pint: 'pint',
    gallon: 'gallon',
    pound: 'pound',
    milliliter: 'milliliter',
    gram: 'gram',
    kilogram: 'kilogram',
    liter: 'liter'
  }

  validates :recipe,
    uniqueness: { scope: :ingredient_id }
end
