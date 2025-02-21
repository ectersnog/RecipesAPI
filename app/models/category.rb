# frozen_string_literal: true

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
