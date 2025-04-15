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
