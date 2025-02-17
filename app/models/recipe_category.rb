# frozen_string_literal: true

class RecipeCategory < ApplicationRecord
  belongs_to :recipe
  belongs_to :category
end
