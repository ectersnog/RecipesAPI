# frozen_string_literal: true

class RecipeIngredient < ApplicationRecord
  belongs_to :recipe
  belongs_to :ingredient

  validates :input,
    presence: true
  validates :recipe,
    uniqueness: { scope: :ingredient_id }
  validates :amount,
    numericality: { greater_than: 0 }
  validates :unit,
    inclusion: { in: Units.all.map(&:to_s) }

  def user_input=(str)
    begin
      parsed = Ingreedy.parse(str.strip)
      ingredient = Ingredient.find_or_create_by(name: parsed.ingredient)
      assign_attributes(amount: parsed.amount, unit: parsed.unit, ingredient:, input: str)
    rescue Ingreedy::ParseFailed, Parslet::ParseFailed
      errors.add(:input, :invalid, message: "#{str} is not a valid ingredient")
    ensure
      assign_attributes(input: str) if input.blank?
    end
  end

  # private

  # def input_validation
  #   begin
  #     parsed = Ingreedy.parse(input.strip)
  #     ingredient = Ingredient.find_or_create_by(name: parsed.ingredient)
  #     assign_attributes(amount: parsed.amount, unit: parsed.unit, ingredient:)
  #   rescue Ingreedy::ParseFailed, Parslet::ParseFailed
  #     errors.add(:input, :invalid, message: "#{input} is not a valid ingredient")
  #   end
  # end
end
