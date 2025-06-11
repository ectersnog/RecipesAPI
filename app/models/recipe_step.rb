# frozen_string_literal: true

class RecipeStep < ApplicationRecord
  include ImageUploader::Attachment.new(:image)

  belongs_to :recipe
  validates :description, presence: true
  validates :position, presence: true
end
