# frozen_string_literal: true

class User < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged
  has_secure_password

  validates :name,
    length: { maximum: 30 },
    presence: true
  validates :email,
    length: { maximum: 255 },
    uniqueness: true,
    format: { with: URI::MailTo::EMAIL_REGEXP }
end
