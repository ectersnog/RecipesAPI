# frozen_string_literal: true

class Units
  # Gets a list of acceptable measurements from the Ingreedy gem
  #
  # @return [Array<Symbol>] list of measurements
  def self.all
    Ingreedy.dictionaries.current.units.keys
  end

  # Get the list of aliases for a measurement type
  #
  # @param unit [String] measurement name
  # @return [Array<String>] list of associated measurement names
  def self.aliases(unit)
    Ingreedy.dictionaries.current.units[unit.to_sym]
  end
end
