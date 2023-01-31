class DoctorsView
    def ask_for(parameter) # "name"
      puts "What's the doctor #{parameter}?"
      gets.chomp
    end
  
    def list(doctors)
      doctors.each do |doctor|
        puts "- ID: #{doctor.id} | Name: #{doctor.name} | Specialty: #{doctor.specialty}"
      end
    end
  end