# frozen_string_literal: true

module V1
  class ProfilesController < ApplicationController
    before_action :authorize

    def show
      render locals: { current_user: }
    end
  end
end
