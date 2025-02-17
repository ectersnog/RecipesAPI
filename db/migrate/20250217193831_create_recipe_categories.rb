# frozen_string_literal: true

class CreateRecipeCategories < ActiveRecord::Migration[8.0]
  def change
    create_table :recipe_categories, id: :uuid do |t|
      t.references :recipe, null: false, foreign_key: true, type: :uuid
      t.references :category, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
