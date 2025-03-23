# frozen_string_literal: true

class IngredientParser
  def self.from_string(line)
    result = Ingreedy.parse(line)
    ingredient = Ingredient.find_or_create_by(name: result.ingredient)
    RecipeIngredient.new(unit: result.unit, amount: result.amount, ingredient:)
  end
end
