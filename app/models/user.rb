# frozen_string_literal: true

# A user of the application.
#
# Represents an account-holder who can log in, receive notifications,
# and interact with the system.
#
# @!attribute [r] id
#   The unique identifier for the user.
#   @return [UUID]
#
# @!attribute [rw] name
#   The full name of the user.
#   @return [String]
#
# @!attribute [rw] email
#   The user's email address (must be unique).
#   @return [String]
#
# @!attribute [r] created_at
#   When the user was created.
#   @return [DateTime]
#
# @!attribute [r] updated_at
#   When the user was last updated.
#   @return [DateTime]

class User < ApplicationRecord
  extend FriendlyId

  friendly_id :name, use: :slugged
  has_secure_password

  has_many :recipes,
    dependent: :destroy

  validates :name,
    length: { maximum: 30 },
    presence: true
  validates :email,
    length: { maximum: 255 },
    uniqueness: true,
    format: { with: URI::MailTo::EMAIL_REGEXP }
end
