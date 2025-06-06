# frozen_string_literal: true

json.data do
  json.call(current_user, :id, :name, :email)
end
