# frozen_string_literal: true

class RecipeImage < ApplicationRecord
  include ImageUploader::Attachment.new(:image)

  belongs_to :recipe
end
