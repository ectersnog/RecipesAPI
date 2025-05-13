# frozen_string_literal: true

class ApplicationController < ActionController::API
  before_action :authorize
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response
  def current_user
    @current_user
  end

  def authorize
    token = request.headers['Authorization:'].split.last
    if token.nil?
      render json: { error: 'No token found' }, status: :unauthorized
    else
      begin
        @decoded = JWT.decode(token, ENV.fetch('JWT_SECRET_KEY'), 'HS256')
        @current_user = User.find_by!(email: @decoded[:email])
      rescue ActiveRecord::RecordNotFound
        render json: { error: 'Not authorized' }, status: :unauthorized
      rescue JWT::ExpiredSignature, JWT::VerificationError, JWT::DecodeError
        render json: { error: 'Token failure' }, status: :unauthorized
      end
    end
  end
end
