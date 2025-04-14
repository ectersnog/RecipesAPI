# frozen_string_literal: true

class RecipeIngredient < ApplicationRecord
  belongs_to :recipe
  belongs_to :ingredient

  validates :amount,
    numericality: { greater_than: 0 }
  validates :recipe,
    uniqueness: { scope: :ingredient_id }
  validates :unit,
    inclusion: { in: Units.all.map(&:to_s) }
  validate :validate_user_input

  def input=(str)
    super
    begin
      parsed = Ingreedy.parse(str.strip)
      ingredient = Ingredient.find_or_create_by(name: parsed.ingredient)
      assign_attributes(amount: parsed.amount, unit: parsed.unit, ingredient:)
    rescue Ingreedy::ParseFailed, Parslet::ParseFailed
      @custom_errors = true
    end
  end

  private

  def validate_user_input
    return unless @custom_errors

    errors.add(:input, :invalid, message: "#{input} is not a valid ingredient")
  end
end
