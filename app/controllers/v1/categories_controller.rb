# frozen_string_literal: true

class V1::CategoriesController < ApplicationController
  def index
    render json: Categories::Index.call(params:)
  end

  def show
    render json: Categories::Show.call(params:)
  end
end
