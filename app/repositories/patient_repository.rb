require 'csv'
require_relative '../models/patient'

class PatientRepository
  def initialize(csv_file, room_repository)
    @csv_file = csv_file
    @patients = []
    @room_repository = room_repository
    load_csv if File.exist?(@csv_file)
    @next_id = @patients.empty? ? 1 : @patients.last.id + 1
  end

  def add(patient)
    patient.id = @next_id
    @patients.push(patient)
    save_csv
    @next_id += 1
  end

  def all
    @patients
  end

  def find(id)
    @patients.select { |patient| patient.id == id }.first
  end

  private

  def load_csv
    CSV.foreach(@csv_file, headers: :first_row) do |row|
      room = @room_repository.find(row['room_id'].to_i)
      patient = Patient.new(id: row["id"].to_i, name: row["name"], age: row["age"].to_i, cured: row["cured"] == "true")
      patient.room = room
      @patients << patient
    end
  end

  def save_csv
    CSV.open(@csv_file, 'wb', headers: :first_row) do |file|
      file << ['id', 'name', 'age', 'cured', 'room_id']
      @patients.each do |patient|
        file << [patient.id, patient.name, patient.age, patient.cured, patient.room.id]
      end
    end
  end

end