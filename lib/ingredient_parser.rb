# frozen_string_literal: true

class IngredientParser
  # Parses ingredients by unit, amount, and ingredient name
  #
  # @param line [String] The line of text to be parsed
  # @return [RecipeIngredient] RecipeIngredient model with all values applied
  def self.from_string(line)
    begin
      result = Ingreedy.parse(line.strip)
      ingredient = Ingredient.find_or_create_by(name: result.ingredient)
      RecipeIngredient.new(unit: result.unit, amount: result.amount, ingredient:)
    rescue Ingreedy::ParseFailed, Parslet::ParseFailed
      raise IngredientParser::Error
    end
  end

  class Error < StandardError
    def message
      "unable to parse ingredient"
    end
  end
end
