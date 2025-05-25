# frozen_string_literal: true

require 'dry/monads'

class ApplicationOperation < Dry::Operation
  def self.call(**args)
    new(**args).call
  end
end
