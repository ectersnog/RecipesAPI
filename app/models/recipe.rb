# frozen_string_literal: true

# @!attribute [r] id
#   The unique identifier for the recipe.
#   @return [String<UUID>]
#
# @!attribute [rw] name
#   The name of the recipe.
#   @return [String]
#
# @!attribute [r] slug
#   The URL-friendly identifier for the recipe.
#   @return [String]
#
# @!attribute [rw] cover_photo
#   The cover photo for the recipe, stored as a JSON object.
#   @return [ImageUploader::Attachment]
#
# @!attribute [rw] user_id
#   The ID of the user who created the recipe.
#   @return [String<UUID>]
#
# @!attribute [rw] nutritional_info
#   Nutritional information for the recipe, stored as JSON.
#   @return [Hash]
#
# @!attribute [rw] description
#   A brief description of the recipe.
#   @return [String]
#
# @!attribute [rw] steps
#   The steps to prepare the recipe.
#   @return [String]
#
# @!attribute [rw] is_gluten_free
#   Whether the recipe is gluten-free.
#   @return [Boolean]
#
# @!attribute [rw] is_carb_free
#   Whether the recipe is carb-free.
#   @return [Boolean]
#
# @!attribute [rw] is_kosher
#   Whether the recipe is kosher.
#   @return [Boolean]
#
# @!attribute [rw] is_paleo
#   Whether the recipe is paleo.
#   @return [Boolean]
#
# @!attribute [rw] is_vegetarian
#   Whether the recipe is vegetarian.
#   @return [Boolean]
#
# @!attribute [rw] is_vegan
#   Whether the recipe is vegan.
#   @return [Boolean]
#
# @!attribute [r] created_at
#   When the ingredient was created.
#   @return [DateTime]
#
# @!attribute [r] updated_at
#   When the ingredient was last updated.
#   @return [DateTime]

class Recipe < ApplicationRecord
  include ImageUploader::Attachment.new(:cover_photo)
  extend FriendlyId

  before_save :update_tsvector

  friendly_id :name, use: :slugged

  belongs_to :user
  has_many :recipe_categories,
    dependent: :destroy
  has_many :categories,
    through: :recipe_categories
  has_many :recipe_ingredients,
    dependent: :destroy
  has_many :ingredients,
    through: :recipe_ingredients
  has_many :recipe_images,
    dependent: :destroy

  scope :search, lambda { |query|
    where("to_tsvector('english', coalesce(name, '')) @@ websearch_to_tsquery('english', ?)", query)
  }

  validates :name,
    length: { maximum: 100 },
    presence: true
  validates :is_gluten_free, :is_carb_free, :is_kosher,
    :is_paleo, :is_vegetarian, :is_vegan,
    inclusion: { in: [true, false] }

  private

  def update_tsvector
    result = self.class.connection.select_value(
      "SELECT to_tsvector('english', #{self.class.connection.quote(name)})"
    )
    self.tsvector_name = result
  rescue StandardError => e
    Rails.logger.error("Failed to update tsvector for recipe #{id}: #{e.message}")
    self.tsvector = nil
  end
end
