# frozen_string_literal: true

class RecipeQuery
  # Recipe Query object returns results from scope
  #
  # @param scope [ActiveRecord::Relation] the base query to build on defaults to Recipe.all
  def initialize(scope = Recipe.all)
    @scope = scope
  end

  # Filters the recipe scope to only include recipes by the given author.
  # @param user [String] The uuid of the user to filter by
  # @return [ActiveRecord::Relation]
  def by_user(user)
    @scope.where(user:)
  end

  # Filters the recipe scope to only include carb free recipes.
  # @return [ActiveRecord::Relation]
  def carb_free
    @scope.where(is_carb_free: true)
  end

  # Filters the recipe scope to only include gluten-free recipes.
  #
  # @return [ActiveRecord::Relation]
  def gluten_free
    @scope.where(is_gluten_free: true)
  end

  # Filters the recipe scope to only include kosher recipes.
  #
  # @return [ActiveRecord::Relation]
  def kosher
    @scope.where(is_kosher: true)
  end

  # Filters the recipe scope to only include paleo recipes.
  #
  # @return [ActiveRecord::Relation]
  def paleo
    @scope.where(is_paleo: true)
  end

  # Filters the recipe scope to only include vegan recipes.
  #
  # @return [ActiveRecord::Relation]
  def vegan
    @scope.where(is_vegan: true)
  end

  # Filters the recipe scope to only include vegetarian recipes.
  #
  # @return [ActiveRecord::Relation]
  def vegetarian
    @scope.where(is_vegetarian: true)
  end

  # Filters the recipe scope to only include the ingredients in the array recipes.
  #
  # @param ingredients [Array<String>] ingredients to return results from
  # @example RecipeQuery.new.ingredient(["cheese", "beef"])
  #
  # @return [ActiveRecord::Relation]
  def ingredient(ingredients = [])
    ingredient_ids = Ingredient.where(name: ingredients).pluck(:id)
    @scope.joins(:recipe_ingredients).where(recipe_ingredients: { ingredient_id: ingredient_ids })
  end

  # Return a paginated list of results
  #
  # @param page [Integer] The page of results to have returned
  # @param per_page [Integer] The amount of results per page to have returned
  #
  # @return [ActiveRecord::Relation]
  def paginate(page = 1, per_page = 10)
    @scope.order(:name).page(page).per(per_page)
  end
end
