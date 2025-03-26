# frozen_string_literal: true

class AddStateEnumToIngredients < ActiveRecord::Migration[8.0]
  def change
    add_column :ingredients, :state, :integer, default: 0

    add_index :ingredients, :name
  end
end
