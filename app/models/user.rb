# frozen_string_literal: true

class User < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged
  validates :name,
    length: { maximum: 30 },
    presence: true
  validates :email,
    presence: true,
    length: { maximum: 255 },
    uniqueness: { case_sensitive: true },
    format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password_digest,
            presence: true
  validates :slug,
            presence: true,
            allow_nil: false
end
