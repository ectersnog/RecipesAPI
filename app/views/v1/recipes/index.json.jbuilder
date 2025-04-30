# frozen_string_literal: true

json.recipes do
  json.partial! 'recipe', collection: @recipes, as: :recipe
end

json.meta do
  json.current_page @recipes.current_page
  json.total_pages @recipes.total_pages
  json.records @recipes.count
  json.total_records @recipes.total_count
end
