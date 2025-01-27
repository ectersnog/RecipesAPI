# frozen_string_literal: true

class CreateCategories < ActiveRecord::Migration[8.0]
  def change
    create_table :categories, id: :uuid do |t|
      t.string :name, null: false
      t.string :slug, null: false
      t.references :parent, null: true, foreign_key: { to_table: :categories }, type: :uuid, index: false
      t.timestamps
    end

    add_index :categories, :name
    add_index :categories, :parent_id
    add_index :categories, :slug, unique: true
  end
end
