require_relative '../models/appointment'

class AppointmentRepository
  def initialize(csv_file, patient_repository, doctor_repository)
    @csv_file = csv_file
    @appointments = []
    @patient_repository = patient_repository
    @doctor_repository = doctor_repository
    @next_id = @appointments.empty? ? 1 : @appointments.last.id + 1
    load_csv if File.exist?(@csv_file)
  end

  def add(appointment)
    appointment.id = @next_id
    @appointments << appointment
    save_csv
    @next_id += 1
  end

  def all
    @appointments
  end

  def find(id)
    @appointments.select { |appointment| appointment.id == id }.first
  end

  private 

  def load_csv
    CSV.foreach(@csv_file, headers: :first_row) do |row|
        appointment = Appointment.new(id: row["id"].to_i)
        # Procurando o paciente atráves do seu ID
        patient_id = row["patient_id"].to_i
        patient = @patient_repository.find(patient_id)

        # Procurando o doutor atráves do ID
        doctor_id = row["doctor_id"].to_i
        doctor = @doctor_repository.find(doctor_id)
        
        # Assimilando o paciente e o doutor ao model Appointment
        appointment.patient = patient
        appointment.doctor = doctor
        
        @appointments << appointment
    end
  end

  def save_csv
    CSV.open(@csv_file, 'wb', headers: :first_row, header_converters: :symbol) do |file|
        file << %i[id patient_id doctor_id] # CSV HEADER
  
        @appointments.each do |appointment|
          file << [appointment.id, appointment.patient.id, appointment.doctor.id]
        end
      end
  end
end