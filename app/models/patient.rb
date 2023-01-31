class Patient
  attr_reader :name, :age, :cured
  attr_accessor :room, :id

  def initialize(attributes = {})
    @id = attributes[:id]
    @name = attributes[:name]
    @age = attributes[:age]
    @cured = attributes[:cured] || false
  end
  
  def cured!
    @cured = true
  end
end

# Patient.new(name: "Gabriel", age: 26)