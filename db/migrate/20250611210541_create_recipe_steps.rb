# frozen_string_literal: true

class CreateRecipeSteps < ActiveRecord::Migration[8.0]
  def change
    create_table :recipe_steps, id: :uuid do |t|
      t.references :recipe, null: false, foreign_key: true, type: :uuid
      t.integer :position, null: false, default: 0
      t.text :description
      t.json :image_data

      t.timestamps
    end
  end
end
