class AddCoverphotoToRecipe < ActiveRecord::Migration[8.0]
  def change
    add_column :recipes, :cover_photo, :json, default: {}
  end
end
