# frozen_string_literal: true

class CreateRecipes < ActiveRecord::Migration[8.0]
  def change
    create_table :recipes, id: :uuid do |t|
      t.string :name, null: false
      t.references :user, { null: false, foreign_key: true, type: :uuid }
      t.json :nutritional_info, default: {}
      t.text :description
      t.text :steps, array: true, default: []
      t.boolean :is_gluten_free, default: false, null: false
      t.boolean :is_carb_free, default: false, null: false
      t.boolean :is_kosher, default: false, null: false
      t.boolean :is_paleo, default: false, null: false
      t.boolean :is_vegetarian, default: false, null: false
      t.boolean :is_vegan, default: false, null: false
      t.string :slug, null: false

      t.timestamps
    end

    add_index :recipes, :name, unique: true
    add_index :recipes, :slug, unique: true
  end
end
