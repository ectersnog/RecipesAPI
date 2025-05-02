# frozen_string_literal: true

json.recipes do
  json.partial! 'recipe', collection: recipes, as: :recipe
end

json.partial! 'shared/meta', locals: { record: recipes }
