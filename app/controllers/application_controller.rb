# frozen_string_literal: true

class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

  def current_user
    @current_user
  end

  private

  def authorize
    token = request.headers['Authorization']
    if token.nil?
      render json: { error: 'No token found' }, status: :unauthorized
    else
      @decoded = JwtLib.token_decode(token.split.last)
      @current_user ||= User.find_by(id: @decoded[:user_id])
    end
  end

  def render_unprocessable_entity_response(exception)
    render json: { errors: exception.record.errors.full_messages }, status: :unprocessable_entity
  end
end
