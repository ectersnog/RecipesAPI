# frozen_string_literal: true

class RecipeQueryAdvanced
  BOOLEAN_FILTERS = %i[
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
    @category_id = params[:category_id] if params.key?(:category_id)
    BOOLEAN_FILTERS.each do |key|
      instance_variable_set("@#{key}", params[key]) if params.key?(key)
    end
  end

  def results
    scope = Recipe.all

    scope = scope.where(user_id: @user_id) unless @user_id.nil?
    if @category_id.present?
      scope = scope.joins(:recipe_categories).where(recipe_categories: { category_id: @category_id })
    end
    BOOLEAN_FILTERS.each do |key|
      value = instance_variable_get("@#{key}")
      scope = scope.where(key => value) unless value.nil?
    end

    scope
  end
end
