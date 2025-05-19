# frozen_string_literal: true

class JwtLib
  JWT_SECRET_KEY = ENV.fetch('JWT_SECRET_KEY')
  ALGORITHM = 'HS256'

  def self.token_decode(token)
    ActiveSupport::HashWithIndifferentAccess.new(
      JWT.decode(token, JWT_SECRET_KEY, true, algorithm: ALGORITHM)[0]
    )
  end

  def self.token_encode(user, exp = 7.days.from_now.to_i)
    payload = {
      user_id: user.id,
      exp:
    }
    JWT.encode(payload, JWT_SECRET_KEY, ALGORITHM)
  end
end
