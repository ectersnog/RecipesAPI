class ChangeRecipesNameToTsVector < ActiveRecord::Migration[8.0]
  def up
    add_column :recipes, :name_tsv, :tsvector
    execute <<-SQL
      UPDATE recipes SET name_tsv = to_tsvector('english', name);
    SQL
    remove_column :recipes, :name
    rename_column :recipes, :name_tsv, :name
    add_index :recipes, :name, using: :gin
  end

  def down
    remove_index :recipes, :name
    rename_column :recipes, :name, :name_tsv
    add_column :recipes, :name, :string
    # Data restoration is not possible here
    remove_column :recipes, :name_tsv
  end
end
