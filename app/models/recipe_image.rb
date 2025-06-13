# frozen_string_literal: true

class RecipeImage < ApplicationRecord
  # @!parse include ImageUploader::Attachment(:image)
  include ImageUploader::Attachment.new(:image)

  belongs_to :recipe

  validates :image, presence: true
end
