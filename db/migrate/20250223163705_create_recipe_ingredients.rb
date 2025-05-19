# frozen_string_literal: true

class CreateRecipeIngredients < ActiveRecord::Migration[8.0]
  def change
    create_table :recipe_ingredients, id: :uuid do |t|
      t.references :recipe, null: false, foreign_key: true, type: :uuid, index: false
      t.references :ingredient, null: false, foreign_key: true, type: :uuid, index: false
      t.float :amount, null: false
      t.string :input, null: false, index: false
      t.string :unit, null: false, default: 'grams'

      t.timestamps
    end

    add_index :recipe_ingredients, :ingredient_id
    add_index :recipe_ingredients, %i[recipe_id ingredient_id], unique: true
  end
end
