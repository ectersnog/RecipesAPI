# frozen_string_literal: true

class AddTsvectorNameToRecipes < ActiveRecord::Migration[8.0]
  def change
    add_column :recipes, :tsvector_name, :tsvector
    add_index :recipes, :tsvector_name, using: :gin
  end
end
