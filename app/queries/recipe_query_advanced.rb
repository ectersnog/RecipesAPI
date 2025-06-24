# frozen_string_literal: true

class RecipeQueryAdvanced
  BOOL_FILTERS = %i[
    is_gluten_free
    is_carb_free
    is_kosher
    is_paleo
    is_vegetarian
    is_vegan
    ].freeze

  def initialize(params:)
    @q = params[:q] if params.key?(:q)
    @user_id = params[:user_id] if params.key?(:user_id)
    @categories = params[:categories].flatten.compact if params.key?(:categories)
    @required_ingredients = params[:required_ingredients].flatten.compact if params.key?(:required_ingredients)
    @excluded_ingredients = params[:excluded_ingredients].flatten.compact if params.key?(:excluded_ingredients)
    BOOL_FILTERS.each do |filter|
      next unless params.key?(filter)

      value = params[filter]
      if value.is_a?(TrueClass) || value.is_a?(FalseClass)
        instance_variable_set("@#{filter}", value)
      end
    end
  end

  def call
    scope = q
    scope = user_id(scope) if @user_id.present?
    scope = categories(scope) if @categories.present?
    scope = required_ingredients(scope) if @required_ingredients.present?
    scope = excluded_ingredients(scope) if @excluded_ingredients.present?
    scope = gluten_free?(scope) if @is_gluten_free.present?
    scope = carb_free?(scope) if @is_carb_free.present?
    scope = kosher?(scope) if @is_kosher.present?
    scope = paleo?(scope) if @is_paleo.present?
    scope = vegetarian?(scope) if @is_vegetarian.present?
    scope = vegan?(scope) if @is_vegan.present?
    scope.uniq
  end

  private

  def q
    if @q.present?
      Recipe.search(@q)
    else
      Recipe.all
    end
  end

  def user_id(scope)
    scope.where(user_id: @user_id)
  end

  def categories(scope)
    category_ids = Category.where(name: @categories).pluck(:id)
    scope.joins(:recipe_categories).where(recipe_categories: { category_id: category_ids })
  end

  def required_ingredients(scope)
    ingredient_ids = Ingredient.where(name: @required_ingredients).pluck(:id)
    scope.joins(:recipe_ingredients).where(recipe_ingredients: { ingredient_id: ingredient_ids })
  end

  def excluded_ingredients(scope)
    ingredient_ids = Ingredient.where(name: @excluded_ingredients).pluck(:id)
    scope.where.not(id: Recipe.joins(:recipe_ingredients).where(recipe_ingredients: { ingredient_id: ingredient_ids }))
  end

  def gluten_free?(scope)
    scope.where(is_gluten_free: @is_gluten_free)
  end

  def carb_free?(scope)
    scope.where(is_carb_free: @is_carb_free)
  end

  def kosher?(scope)
    scope.where(is_kosher: @is_kosher)
  end

  def paleo?(scope)
    scope.where(is_paleo: @is_paleo)
  end

  def vegetarian?(scope)
    scope.where(is_vegetarian: @is_vegetarian)
  end

  def vegan?(scope)
    scope.where(is_vegan: @is_vegan)
  end
end
