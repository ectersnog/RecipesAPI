# frozen_string_literal: true

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
