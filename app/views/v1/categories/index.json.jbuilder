# frozen_string_literal: true

json.categories do
  json.partial! 'category', collection: @categories, as: :category
end

json.meta do
  json.current_page @categories.current_page
  json.total_pages @categories.total_pages
  json.records @categories.count
  json.total_records @categories.total_count
end
