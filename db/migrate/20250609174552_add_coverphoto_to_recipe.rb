# frozen_string_literal: true

class AddCoverphotoToRecipe < ActiveRecord::Migration[8.0]
  def change
    add_column :recipes, :cover_photo_data, :json
  end
end
