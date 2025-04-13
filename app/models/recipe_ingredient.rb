# frozen_string_literal: true

class RecipeIngredient < ApplicationRecord
  belongs_to :recipe
  belongs_to :ingredient

  before_validation :user_input
  validates :amount,
    numericality: { greater_than: 0 }
  validates :recipe,
    uniqueness: { scope: :ingredient_id }
  validates :unit,
    inclusion: { in: Units.all.map(&:to_s) }

  private

  def user_input
    begin
      return if Rails.env.test? && input.blank?

      parsed = Ingreedy.parse(input.strip)
      ingredient = Ingredient.find_or_create_by(name: parsed.ingredient)
      assign_attributes(amount: parsed.amount, unit: parsed.unit, ingredient:)
    rescue Ingreedy::ParseFailed, Parslet::ParseFailed
      errors.add(:input, :invalid, message: "#{input} is not a valid ingredient")
    end
  end
end
