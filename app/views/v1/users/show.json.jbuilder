# frozen_string_literal: true

json.data do
  if current_user
    json.call(user, :id, :name, :email)
  else
    json.call(user, :name)
  end
end
