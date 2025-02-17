# frozen_string_literal: true

class Ingredient < ApplicationRecord
  extend FriendlyId

  friendly_id :name, use: :slugged

  validates :name, presence: true
end
