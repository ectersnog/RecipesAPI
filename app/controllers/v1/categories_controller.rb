# frozen_string_literal: true

class V1::CategoriesController < ApplicationController
  before_action :set_category, only: [:show]
  def index
    @categories = Category.all
    render json: @categories
  end

  def show
    render json: @category
  end

  private

  def set_category
    @category = Category.find_by(slug: params[:slug].downcase)
  end

  def category_params
    params.require(:category).expect(:name, :id, :slug)
  end
end
