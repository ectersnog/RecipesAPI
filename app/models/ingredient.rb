# frozen_string_literal: true

# @!attribute [r] id
#   The unique identifier for the ingredient.
#   @return [String<UUID>]
#
# @!attribute [rw] name
#   The name of the ingredient.
#   @return [String]
#
# @!attribute [rw] nutritional_info
#   Nutritional information for the ingredient, stored as JSON.
#   @return [Hash]
#
# @!attribute [r] slug
#   The URL-friendly identifier for the ingredient.
#   @return [String]
#
# @!attribute [rw] state
#   The state of the ingredient (e.g., pending, published, archived).
#   @return [Integer]
#
# @!attribute [r] created_at
#   When the ingredient was created.
#   @return [DateTime]
#
# @!attribute [r] updated_at
#   When the ingredient was last updated.
#   @return [DateTime]

class Ingredient < ApplicationRecord
  extend FriendlyId

  friendly_id :name, use: :slugged

  has_many :recipe_ingredients,
    dependent: :destroy
  has_many :recipes,
    through: :recipe_ingredients

  enum :state, { pending: 0, published: 1, archived: 2 }

  normalizes :name, with: ->(name) { name.downcase.encode('utf-8') }
  validates :name, presence: true
end
