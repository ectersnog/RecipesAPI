# frozen_string_literal: true

json.meta do
  json.current_page record.current_page
  json.total_pages record.total_pages
  json.records record.count
  json.total_records record.total_count
end
