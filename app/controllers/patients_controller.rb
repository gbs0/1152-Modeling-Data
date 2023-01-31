require_relative '../views/patients_view'
require_relative '../views/rooms_view'

class PatientsController
  def initialize(patient_repository, room_repository)
    @patient_repository = patient_repository
    @room_repository = room_repository
    @view = PatientsView.new
    @rooms_view = RoomsView.new
  end

  # Cria um paciente no CSV
  def create
    name = @view.ask_for("name")
    age = @view.ask_for("age").to_i
    patient = Patient.new(name: name, age: age)

    # Assimilar uma sala ao paciente
    rooms = @room_repository.all
    @rooms_view.list(rooms)
    room_id = @rooms_view.ask_for("ID").to_i
    patient.room = @room_repository.find(room_id)

    # Por ultimo, adicionamos o paciente com as infos no repositório
    @patient_repository.add(patient)
  end

  # Lista todos os pacientes atuais
  def list
    patients = @patient_repository.all
    @view.list(patients)
  end
end