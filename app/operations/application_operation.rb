# frozen_string_literal: true

class ApplicationOperation
  def self.call(**args)
    new(**args).call
  end
end
