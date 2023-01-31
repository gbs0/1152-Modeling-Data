class AppointmentsView
  def ask_date
    puts "Enter date of appointment: (yyyy-mm-dd):"
    gets.chomp
  end
    
  def list(appointments)
    puts 'Appointments List'
    puts '-' * 30
    appointments.each do |appointment|
      puts "#{appointment.id} - Doctor: #{appointment.doctor.name} - Patient: #{appointment.patient.name}"
    end
    puts '-' * 30
  end
end