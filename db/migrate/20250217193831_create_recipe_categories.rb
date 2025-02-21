# frozen_string_literal: true

class CreateRecipeCategories < ActiveRecord::Migration[8.0]
  def change
    create_table :recipe_categories, id: :uuid do |t|
      t.references :recipe, null: false, foreign_key: true, type: :uuid, index: false
      t.references :category, null: false, foreign_key: true, type: :uuid, index: false

      t.timestamps
    end

    add_index :recipe_categories, :category_id
    add_index :recipe_categories, %i[recipe_id category_id], unique: true
  end
end
