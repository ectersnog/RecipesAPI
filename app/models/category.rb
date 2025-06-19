# frozen_string_literal: true

# @!attribute [r] id
#   The unique identifier for the category.
#   @return [String<UUID>]
#
# @!attribute [rw] name
#   The name of the category.
#   @return [String]
#
# @!attribute [rw] slug
#   The URL-friendly identifier for the category.
#   @return [String]
#
# @!attribute [rw] parent_id
#   The ID of the parent category, if any.
#   @return [String<UUID>]
#
# @!attribute [r] created_at
#   When the category was created.
#   @return [DateTime]
#
# @!attribute [r] updated_at
#   When the category was last updated.
#   @return [DateTime]

class Category < ApplicationRecord
  extend FriendlyId

  friendly_id :name, use: :slugged

  has_many :subcategories,
    class_name: 'Category',
    foreign_key: :parent_id,
    dependent: :destroy
  has_many :recipe_categories,
    dependent: :destroy
  has_many :recipes,
    through: :recipe_categories
  belongs_to :parent,
    class_name: 'Category',
    optional: true

  validates :name,
    presence: true,
    uniqueness: true
end
