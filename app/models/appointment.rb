class Appointment
  attr_accessor :id, :doctor, :patient
  
  def initialize(attributes = {})
    @id = attributes[:id]
  end
end