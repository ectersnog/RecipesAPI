# frozen_string_literal: true

class Ingredient < ApplicationRecord
  extend FriendlyId

  friendly_id :name, use: :slugged

  has_many :recipe_ingredients,
    dependent: :destroy
  has_many :recipes,
    through: :recipe_ingredients

  enum :state, { pending: 0, published: 1, archived: 2, deleted: 3 }

  before_validation :normalize_name
  validates :name, presence: true

  private

  def normalize_name
    self.name = name.to_s.downcase
    self.name = name.encode("UTF-8", invalid: :replace, undef: :replace, replace: "")
  end
end
