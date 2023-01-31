require_relative '../views/appointments_view'
require_relative '../views/patients_view'
require_relative '../views/doctors_view'

class AppointmentsController
  def initialize(appointment_repository, patient_repository, doctor_repository)
    @appointment_repository = appointment_repository
    @doctor_repository = doctor_repository
    @patient_repository = patient_repository
    @view = AppointmentsView.new
    @patients_view = PatientsView.new
    @doctors_view = DoctorsView.new
  end

  def create
    # Perguntamos qual o paciente a ser atendido
    patients = @patient_repository.all
    @patients_view.list(patients)
    patient_id = @patients_view.ask_for("id").to_i
    patient = @patient_repository.find(patient_id)

    # Perguntar qual o doutor irá atender esse paciente
    doctors = @doctor_repository.all
    @doctors_view.list(doctors)
    doctor_id = @doctors_view.ask_for("id").to_i
    doctor = @doctor_repository.find(doctor_id)

    appointment = Appointment.new
    appointment.patient = patient
    appointment.doctor = doctor

    @appointment_repository.add(appointment)
  end

  def list
    appointments = @appointment_repository.all
    @view.list(appointments)
  end
end