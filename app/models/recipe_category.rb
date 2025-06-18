# frozen_string_literal: true

# @!attribute [r] id
#   The unique identifier for the recipe category.
#   @return [String<UUID>]
#
# @!attribute [rw] recipe_id
#   The unique identifier for the recipe.
#   @return [String<UUID>]
#
# @!attribute [rw] category_id
#   The unique identifier for the category.
#   @return [String<UUID>]
#
# @!attribute [r] created_at
#   When the ingredient was created.
#   @return [DateTime]
#
# @!attribute [r] updated_at
#   When the ingredient was last updated.
#   @return [DateTime]

class RecipeCategory < ApplicationRecord
  belongs_to :recipe
  belongs_to :category

  validates :recipe,
    uniqueness: { scope: :category_id }
end
