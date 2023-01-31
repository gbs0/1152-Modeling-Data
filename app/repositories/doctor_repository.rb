require 'csv'
require_relative '../models/doctor'

class DoctorRepository
  def initialize(csv_file)
    @csv_file = csv_file
    @doctors = []
    load_csv if File.exist?(@csv_file)
    @next_id = @doctors.empty? ? 1 : @doctors.last.id + 1
  end

#   def add(room)
#     room.id = @next_id
#     @rooms.push(room)
#     save_csv
#     @next_id += 1
#   end

  def all
    @doctors
  end

  def find(id)
    @doctors.select { |doctor| doctor.id == id }.first
  end

  private

  def load_csv
    CSV.foreach(@csv_file, headers: :first_row) do |row|
      @doctors << Doctor.new(id: row["id"].to_i, name: row["name"], specialty: row["specialty"])
    end
  end

#   def save_csv
#     CSV.open(@csv_file, 'wb', headers: :first_row) do |file|
#       file << ['id', 'name', 'specialty']
#       @doctors.each do |doctor|
#         file << [doctor.id, doctor.name, doctor.specialty]
#       end
#     end
#   end

end