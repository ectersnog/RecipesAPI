# frozen_string_literal: true

class CreateRecipeImages < ActiveRecord::Migration[8.0]
  def change
    create_table :recipe_images, id: :uuid do |t|
      t.references :recipe, null: false, foreign_key: true, type: :uuid
      t.json :image_data

      t.timestamps
    end
  end
end
