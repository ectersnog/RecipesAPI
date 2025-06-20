# frozen_string_literal: true

module AuthHelpers
  TEST_USER_PASSWORD = 'testing'

  def login_token
    token = JwtLib.token_encode(current_user)
    "Bearer #{token}"
  end

  def current_user
    @current_user ||= create(:user,
      password: TEST_USER_PASSWORD,
      password_confirmation: TEST_USER_PASSWORD
    )
  end
end
