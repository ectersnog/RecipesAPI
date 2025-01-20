# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users, id: :uuid do |t|
      t.string :name, null: false
      t.citext :email, null: false
      t.string :password_digest, null: false
      t.json :avatar_data
      t.string :slug, null: false
      t.timestamps
    end

    add_index :users, :email, unique: true
    add_index :users, :slug, unique: true
  end
end
