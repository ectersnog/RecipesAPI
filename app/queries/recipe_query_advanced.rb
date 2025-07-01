# frozen_string_literal: true

class RecipeQueryAdvanced
  # Recipe Query Advanced object returns results from scope
  #
  # @param scope [ActiveRecord::Relation] the base query to build on defaults to Recipe.all
  # @param params [Hash] a hash of filters
  # @option params [Integer] :user_id the ID of the user
  # @option params [Boolean] :is_carb_free whether the recipe is carb free
  # @option params [Boolean] :is_kosher whether the recipe is kosher
  # @option params [Boolean] :is_paleo whether the recipe is paleo
  # @option params [Boolean] :is_gluten_free whether the recipe is gluten-free
  # @option params [Boolean] :is_vegetarian whether the recipe is vegetarian
  # @option params [Boolean] :is_vegan whether the recipe is vegan
  # @option params [String] :required_ingredients a comma-separated list of ingredient IDs that must be included
  # @option params [String] :excluded_ingredients a comma-separated list of ingredient IDs that must not be included
  # @option params [String] :categories a comma-separated list of category IDs to filter by
  #
  # @return [ActiveRecord::Relation] the resulting scope after applying filters

  PAGINATE = ->(scope, page = 1, per_page = 10) { scope.page(page).per(per_page) }

  def self.call(params = {}, scope: Recipe.all)
    new.call(params, scope:)
  end

  def call(params, scope:)
    return scope if params.empty?

    query = []
    query += process_booleans(params)

    if params[:required_ingredients].present?
      query << { recipe_ingredients: { ingredient_id: params[:required_ingredients].split(',') } }
    end

    if params[:categories].present?
      query << { recipe_categories: { category_id: params[:categories].split(',') } }
    end

    if params[:excluded_ingredients].present?
      scope = parse_excluded_ingredients(params[:excluded_ingredients], scope)
    end

    valid = query.reject { it.values.all?(&:nil?) }

    result = scope.includes(:recipe_ingredients, :recipe_categories)
      .where(valid.reduce({}, :merge))
      .order(:name)

    result = result.search(params[:q]) if params[:q].present?
    if params[:page] || params[:per_page]
      PAGINATE.call(result, params[:page], params[:per_page])
    else
      result
    end
  end

  private

  def process_booleans(params)
    query = []
    query << { user_id: params[:user_id] }
    query << { is_carb_free: boolean(params[:is_carb_free]) }
    query << { is_kosher: boolean(params[:is_kosher]) }
    query << { is_paleo: boolean(params[:is_paleo]) }
    query << { is_gluten_free: boolean(params[:is_gluten_free]) }
    query << { is_vegetarian: boolean(params[:is_vegetarian]) }
    query << { is_vegan: boolean(params[:is_vegan]) }
    query
  end

  def parse_excluded_ingredients(excluded_ingredients, scope)
    excluded_ids = excluded_ingredients.split(',')
    scope.where.not(
      id: Recipe.joins(:recipe_ingredients)
                .where(recipe_ingredients: { ingredient_id: excluded_ids })
                .select(:id)
    )
  end

  def boolean(value)
    return if value.nil?

    ActiveModel::Type::Boolean.new.cast(value.to_s.downcase)
  end
end
