# frozen_string_literal: true

# @!attribute [r] id
#   The unique identifier for the recipe ingredient.
#   @return [String<UUID>]
#
# @!attribute [rw] recipe_id
#   The unique identifier for the recipe.
#   @return [String<UUID>]
#
# @!attribute [rw] ingredient_id
#   The unique identifier for the ingredient.
#   @return [String<UUID>]
#
# @!attribute [rw] amount
#   The amount of the ingredient used in the recipe.
#   @return [Float]
#
# @!attribute [rw] input
#   The user input for the ingredient, which can be parsed to extract amount and unit.
#   @return [String]
#
# @!attribute [rw] unit
#   The unit of measurement for the ingredient (e.g., grams, cups).
#   @return [String]
#
# @!attribute [r] created_at
#   When the ingredient was created.
#   @return [DateTime]
#
# @!attribute [r] updated_at
#   When the ingredient was last updated.
#   @return [DateTime]

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
    return if parser.nil?

    ingredient = Ingredient.find_or_create_by(name: parser.ingredient)
    assign_attributes(amount: parser.amount, unit: parser.unit, ingredient:)
  end

  private

  def parser
    return if input.blank?

    @parser ||= Ingreedy.parse(input.to_s.strip)
  rescue Ingreedy::ParseFailed, Parslet::ParseFailed
    nil
  end

  def validate_user_input
    return unless parser.nil?

    errors.add(:input, :invalid, msg: "Unable to parse input")
  end
end
