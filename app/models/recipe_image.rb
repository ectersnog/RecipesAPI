# frozen_string_literal: true

# @!attribute [r] id
#   The unique identifier for the recipe image.
#   @return [String<UUID>]
#
# @!attribute [rw] recipe_id
#   The unique identifier for the recipe.
#   @return [String<UUID>]
#
# @!attribute [rw] image
#   The image for a recipe, stored as a JSON object.
#   @return [ImageUploader::Attachment]
#
# @!attribute [r] created_at
#   When the recipe image was created.
#   @return [DateTime]
#
# @!attribute [r] updated_at
#   When the recipe image was last updated.
#   @return [DateTime]

class RecipeImage < ApplicationRecord
  # @!parse include ImageUploader::Attachment(:image)
  include ImageUploader::Attachment.new(:image)

  belongs_to :recipe

  validates :image, presence: true
end
