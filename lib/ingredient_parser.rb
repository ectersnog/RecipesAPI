# frozen_string_literal: true

class IngredientParser
  class Error < StandardError
  end

  # Parses ingredients by unit, amount, and ingredient name
  # @param line [String] The line of text to be parsed
  # @raise [IngredientParser::Error]
  # @return [RecipeIngredient] RecipeIngredient model with all values applied
  def self.from_string(line)
    begin
      result = Ingreedy.parse(line.strip)
      ingredient = Ingredient.find_or_create_by(name: result.ingredient)
      RecipeIngredient.new(unit: result.unit, amount: result.amount, ingredient:)
    rescue Ingreedy::ParseFailed, Parslet::ParseFailed
      # raise IngredientParser::Error
      instance = RecipeIngredient.new
      instance.errors.add(:ingredient, :invalid, message: "Unable to parse ingredient: #{line.strip}")
      instance
    end
  end
end
