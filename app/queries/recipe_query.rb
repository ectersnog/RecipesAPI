# frozen_string_literal: true

class RecipeQuery
  def initialize(scope = Recipe.all)
    @scope = scope
  end

  def carb_free
    @scope.where(is_carb_free: true)
  end

  def gluten_free
    @scope.where(is_gluten_free: true)
  end

  def kosher
    @scope.where(is_kosher: true)
  end

  def paleo
    @scope.where(is_paleo: true)
  end

  def vegan
    @scope.where(is_vegan: true)
  end

  def vegetarian
    @scope.where(is_vegetarian: true)
  end

  def ingredient(ingredients = [])
    ingredient_ids = Ingredient.where(name: ingredients).pluck(:id)
    @scope.joins(:recipe_ingredients).where(recipe_ingredients: { ingredient_id: ingredient_ids })
  end

  def paginate(page = 0, per_page = 10)
    @scope.page(page).per(per_page)
  end
end
