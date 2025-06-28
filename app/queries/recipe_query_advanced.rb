# frozen_string_literal: true

class RecipeQueryAdvanced
  ALLOWED_KEYS = %i[
    user_id
    is_carb_free
    is_kosher
    is_paleo
    is_gluten_free
    is_vegetarian
    is_vegan
    required_ingredients
    excluded_ingredients
    categories
    q
  ].freeze

  def initialize(params, scope: Recipe.all)
    @scope = scope
    @params = params.symbolize_keys.slice(*ALLOWED_KEYS)
  end

  def self.call(params, scope: Recipe.all)
    new(params, scope:).call
  end

  def call
    query = []

    query << { user_id: @params[:user_id] }
    query << { is_carb_free: boolean(@params[:is_carb_free]) }
    query << { is_kosher: boolean(@params[:is_kosher]) }
    query << { is_paleo: boolean(@params[:is_paleo]) }
    query << { is_gluten_free: boolean(@params[:is_gluten_free]) }
    query << { is_vegetarian: boolean(@params[:is_vegetarian]) }
    query << { is_vegan: boolean(@params[:is_vegan]) }

    if @params[:required_ingredients].present?
      query << { recipe_ingredients: { ingredient_id: @params[:required_ingredients].split(',') } }
    end

    if @params[:categories].present?
      query << { recipe_categories: { category_id: @params[:categories].split(',') } }
    end

    if @params[:excluded_ingredients].present?
      query << { recipe_ingredients: { ingredient_id: @params[:excluded_ingredients].split(',') } }
    end

    valid = query.reject { it.values.all?(&:nil?) }
    if @params[:q].present?
      Recipe.includes(:recipe_categories, :recipe_ingredients).where(valid.reduce({}, :merge)).search(@params[:q])
    else
      Recipe.includes(:recipe_categories, :recipe_ingredients).where(valid.reduce({}, :merge))
    end
  end

  private

  def boolean(value)
    return if value.nil?

    ActiveModel::Type::Boolean.new.cast(value.to_s.downcase)
  end
end
