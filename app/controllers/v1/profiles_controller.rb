# frozen_string_literal: true

module V1
  class ProfilesController < ApplicationController
    def show
      user = Profiles::Show.call(user: current_user)
      if user
        render locals: { user: }
      else
        render json: { errors: 'Not logged in' }, status: :unauthorized
      end
    end
  end
end
