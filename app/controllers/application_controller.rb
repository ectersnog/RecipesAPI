# frozen_string_literal: true

class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
  rescue_from JWT::ExpiredSignature, with: :render_expired_signature
  rescue_from JWT::VerificationError, with: :render_unauthorized_responseO

  def current_user
    @current_user ||= find_authorized_user
  end

  private

  def authorize
    return if current_user.present?

    render json: { errors: 'Not Authorized' }, status: :unauthorized
  end

  def find_authorized_user
    token = request.headers['Authorization']
    return if token.nil?

    decoded = JwtLib.token_decode(token.split.last)
    User.find_by(id: decoded[:user_id])
  end

  def render_unprocessable_entity_response(exception)
    render json: { errors: exception.record.errors.full_messages }, status: :unprocessable_entity
  end

  def render_expired_signature
    render json: { errors: "Token expired" }, status: :unauthorized
  end

  def render_unauthorized_response
    render json: { errors: "JWT token verification error" }, status: :unauthorized
  end

  def render_not_found
    render json: { errors: 'Not Found' }, status: :not_found
  end
end
