# frozen_string_literal: true

class CreateIngredients < ActiveRecord::Migration[8.0]
  def change
    create_table :ingredients, id: :uuid do |t|
      t.string :name, null: false
      t.json :nutritional_info, default: {}
      t.string :slug

      t.timestamps
    end
  end
end
