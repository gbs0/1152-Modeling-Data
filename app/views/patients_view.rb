class PatientsView
  def ask_for(parameter) # "name"
    puts "What's the patient #{parameter}?"
    gets.chomp
  end

  def list(patients)
    patients.each do |patient|
      puts "- ID: #{patient.id} | Name: #{patient.name} | Age: #{patient.age} | Room: #{patient.room ? "Patient is on #{patient.room.number} room" : "There's no room yet"}"
    end
  end
end