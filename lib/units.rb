# frozen_string_literal: true

class Units
  def self.all
    Ingreedy.dictionaries.current.units.keys
  end

  def self.aliases(unit)
    Ingreedy.dictionaries.current.units(unit.to_sym)
  end
end
